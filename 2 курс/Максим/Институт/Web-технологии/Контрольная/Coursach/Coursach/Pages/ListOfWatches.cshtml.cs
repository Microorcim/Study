using Coursach.Data;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;

namespace Coursach.Pages
{
    public class ListOfWatchesModel : PageModel
    {
        private readonly Coursach.Data.ApplicationDbContext _context;
        private readonly IMemoryCache cache;

        public ListOfWatchesModel(Coursach.Data.ApplicationDbContext context, IMemoryCache memoryCache)
        {
            _context = context;
            cache = memoryCache;

        }

        public IList<Watch> Watch { get; set; } = default!;

        public async Task OnGetAsync()
        {
            #region Test

            //Random random = new Random();
            //List<Watch> watches = new List<Watch>();

            //var brands = _context.Brands.ToList();
            //var countries = _context.Countries.ToList();
            //var styles = _context.Styles.ToList();
            //var glassTypes = _context.GlassTypes.ToList();
            //var waterResistants = _context.WaterResistants.ToList();
            //var caseMaterials = _context.CaseMaterials.ToList();
            //var caseForms = _context.CaseForms.ToList();
            //var caseSizes = _context.CaseSizes.ToList();
            //var caseColors = _context.CaseColors.ToList();
            //var clockFaces = _context.ClockFaces.ToList();
            //var numberTypes = _context.NumberTypes.ToList();
            //var backlights = _context.Backlights.ToList();
            //var bracelets = _context.Bracelets.ToList();
            //var braceletColors = _context.BraceletColors.ToList();
            //var files = Directory.GetFiles(@"C:\Users\sirqu\OneDrive\Изображения\Course\");

            //for (int i = 0; i < 1000; i++)
            //{
            //    var imageStr = files[random.Next(0, files.Count())];

            //    Watch watch = new Watch()
            //    {
            //        ModelName = $"Модель {i}",
            //        IsFavorite = false,
            //        Count = (uint)random.Next(0, 40),
            //        Genre = (Genre)random.Next(0, 2),
            //        Price = random.Next(10000, 1000000),
            //        Description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce egestas bibendum mauris in vehicula. Praesent id pretium nibh. Nunc non massa vel mi luctus congue. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Donec eu pharetra massa. In et finibus nulla. Morbi efficitur condimentum urna ac scelerisque. Donec eu dapibus ipsum. Fusce tincidunt orci urna, vel hendrerit nunc finibus et. Sed malesuada finibus molestie. Phasellus ut tempor nibh. Praesent faucibus maximus ipsum viverra convallis. Suspendisse potenti. Nulla maximus ultricies luctus. Vivamus vitae nisi vitae tellus sagittis egestas.",
            //        Brand = brands[random.Next(0, brands.Count)],
            //        Country = countries[random.Next(0, countries.Count)],
            //        Style = styles[random.Next(0, styles.Count)],
            //        Mechanism = (Mechanism)random.Next(0, 2),
            //        GlassType = glassTypes[random.Next(0, glassTypes.Count)],
            //        WaterResistant = waterResistants[random.Next(0, waterResistants.Count)],
            //        CaseMaterial = caseMaterials[random.Next(0, caseMaterials.Count)],
            //        CaseForm = caseForms[random.Next(0, caseForms.Count)],
            //        CaseSize = caseSizes[random.Next(0, caseSizes.Count)],
            //        CaseColor = caseColors[random.Next(0, caseColors.Count)],
            //        ClockFace = clockFaces[random.Next(0, clockFaces.Count)],
            //        NumberType = numberTypes[random.Next(0, numberTypes.Count)],
            //        Backlight = backlights[random.Next(0, backlights.Count)],
            //        Bracelet = bracelets[random.Next(0, bracelets.Count)],
            //        BraceletColor = braceletColors[random.Next(0, braceletColors.Count)],
            //        FileExtension = Path.GetExtension(imageStr),
            //        Bytes = System.IO.File.ReadAllBytes(imageStr),
            //        Size = new System.IO.FileInfo(imageStr).Length
            //    };

            //    watches.Add(watch);
            //}

            //_context.Watches.AddRange(watches);
            //_context.SaveChanges();
            #endregion

            if (_context.Watches != null)
            {
                Watch = await _context.Watches.Include(x => x.Brand).ToListAsync();
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
