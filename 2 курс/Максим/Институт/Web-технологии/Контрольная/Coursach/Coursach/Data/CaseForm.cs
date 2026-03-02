namespace Coursach.Data
{
    public class CaseForm
    {
        public Guid Id { get; set; } = Guid.NewGuid();
        public string Name { get; set; }
        public List<Watch> Watches { get; set; } = new List<Watch>();
    }
}
