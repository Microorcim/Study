using System.ComponentModel.DataAnnotations;

namespace Coursach.Data
{
    public enum Genre
    {
        [Display(Name = "Мужские")]
        Male,
        [Display(Name = "Женские")]
        Female,
        [Display(Name = "Унисекс")]
        Unisex,
        [Display(Name = "Детские")]
        Child
    }
}
