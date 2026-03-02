namespace Coursach.Data
{
    public class Watch
    {
        public Guid Id { get; set; } = Guid.NewGuid();
        public string ModelName { get; set; }
        public bool IsFavorite { get; set; }
        public uint Count { get; set; }
        public Genre Genre { get; set; }
        public float Price { get; set; }
        public string Description { get; set; }
        public Brand Brand { get; set; }
        public Country Country { get; set; }
        public Style Style { get; set; }
        public Mechanism Mechanism { get; set; }
        public GlassType GlassType { get; set; }
        public WaterResistant WaterResistant { get; set; }
        public CaseMaterial CaseMaterial { get; set; }
        public CaseForm CaseForm { get; set; }
        public CaseSize CaseSize { get; set; }
        public CaseColor CaseColor { get; set; }
        public ClockFace ClockFace { get; set; }
        public NumberType NumberType { get; set; }
        public Backlight? Backlight { get; set; }
        public Bracelet Bracelet { get; set; }
        public BraceletColor BraceletColor { get; set; }
        public List<Decoration> Decorations { get; set; } = new List<Decoration>();
        public List<Additionall> Additionalls { get; set; } = new List<Additionall>();
        public byte[] Bytes { get; set; }
        public string FileExtension { get; set; }
        public decimal Size { get; set; }
    }
}
