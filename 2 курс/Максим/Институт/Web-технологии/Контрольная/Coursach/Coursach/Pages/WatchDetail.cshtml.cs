using Coursach.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;

namespace Coursach.Pages
{
    public class WatchDetailModel : PageModel
    {
        private readonly Coursach.Data.ApplicationDbContext _context;
        private readonly IMemoryCache cache;

        public WatchDetailModel(Coursach.Data.ApplicationDbContext context, IMemoryCache memoryCache)
        {
            _context = context;
            cache = memoryCache;

        }

        public Watch Watch { get; set; } = default!;

        public async Task<IActionResult> OnGetAsync(Guid? id)
        {
            List<Watch> CartWathces;
            cache.TryGetValue("cart", out CartWathces);

            if (CartWathces == null)
            {
                CartWathces = new List<Watch>();
                cache.Set("cart", CartWathces, new MemoryCacheEntryOptions().SetAbsoluteExpiration(TimeSpan.FromDays(30)));
            }

            float price = CartWathces.Select(x => x.Price).Sum();

            ViewData["cartPrice"] = $"{price} руб";

            if (id == null || _context.Watches == null)
            {
                return NotFound();
            }

            var watch = await _context.Watches.Include(x => x.Brand).
                                                Include(x => x.Country).
                                                Include(x => x.Country).
                                                Include(x => x.Style).
                                                Include(x => x.GlassType).
                                                Include(x => x.WaterResistant).
                                                Include(x => x.CaseMaterial).
                                                Include(x => x.CaseColor).
                                                Include(x => x.CaseForm).
                                                Include(x => x.CaseSize).
                                                Include(x => x.ClockFace).
                                                Include(x => x.NumberType).
                                                Include(x => x.Backlight).
                                                Include(x => x.Bracelet).
                                                Include(x => x.BraceletColor).
                                                FirstOrDefaultAsync(m => m.Id == id);
            if (watch == null)
            {
                return NotFound();
            }
            else
            {
                Watch = watch;
            }

            return Page();
        }

        public async Task OnPostAddToCartAsync(Guid id)
        {
            List<Watch> CartWathces;
            cache.TryGetValue("cart", out CartWathces);

            Watch = _context.Watches.FirstOrDefault(x => x.Id == id);

            if (CartWathces == null)
                CartWathces = new List<Watch>();
            CartWathces.Add(Watch);
            cache.Set("cart", CartWathces, new MemoryCacheEntryOptions().SetAbsoluteExpiration(TimeSpan.FromDays(30)));

            float price = CartWathces.Select(x => x.Price).Sum();

            ViewData["cartPrice"] = $"{price} руб";
        }
    }
}
