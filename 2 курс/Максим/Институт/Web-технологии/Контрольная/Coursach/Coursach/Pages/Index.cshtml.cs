using Coursach.Data;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;

namespace Coursach.Pages
{
    public class IndexModel : PageModel
    {
        private readonly ILogger<IndexModel> _logger;
        private readonly Coursach.Data.ApplicationDbContext _context;
        private readonly IMemoryCache cache;

        public IndexModel(ILogger<IndexModel> logger, Coursach.Data.ApplicationDbContext context, IMemoryCache memoryCache)
        {
            _logger = logger;
            _context = context;

            cache = memoryCache;
        }

        public List<Watch> FavoriteWathes { get; set; } = default!;

        public async Task OnGetAsync()
        {
            if (_context.Watches != null)
            {
                FavoriteWathes = await _context.Watches.Where(x => x.IsFavorite).Include(x => x.Brand).Take(6).ToListAsync();
            }

            List<Watch> CartWathces;
            cache.TryGetValue("cart", out CartWathces);

            if (CartWathces == null)
            {
                CartWathces = new List<Watch>();
                cache.Set("cart", CartWathces, new MemoryCacheEntryOptions().SetAbsoluteExpiration(TimeSpan.FromDays(30)));
            }

            float price = CartWathces.Select(x => x.Price).Sum();

            ViewData["cartPrice"] = $"{price} руб";
        }
    }
}
