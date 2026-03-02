using Coursach.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Caching.Memory;
using System.Diagnostics;

namespace Coursach.Pages
{
    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    [IgnoreAntiforgeryToken]
    public class ErrorModel : PageModel
    {
        public string? RequestId { get; set; }

        public bool ShowRequestId => !string.IsNullOrEmpty(RequestId);

        private readonly ILogger<ErrorModel> _logger;
        private readonly IMemoryCache cache;

        public ErrorModel(ILogger<ErrorModel> logger, IMemoryCache memoryCache)
        {
            _logger = logger;
            cache = memoryCache;

            ViewData["cartPrice"] = "0 руб";
        }

        public void OnGet()
        {
            RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier;

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
