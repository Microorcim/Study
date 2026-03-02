using System.ComponentModel.DataAnnotations;

namespace Coursach.Data
{
    public enum Mechanism
    {
        [Display(Name = "Механический")]
        Mechanical,
        [Display(Name = "Кварцевый")]
        Quartz,
        [Display(Name = "Умные часы")]
        Smart
    }
}
