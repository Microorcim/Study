using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace Coursach.Data
{
    public class ApplicationDbContext : IdentityDbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        { }

        #region Модельки 
        public DbSet<Brand> Brands { get; set; }
        public DbSet<Country> Countries { get; set; }
        public DbSet<Style> Styles { get; set; }
        public DbSet<GlassType> GlassTypes { get; set; }
        public DbSet<WaterResistant> WaterResistants { get; set; }
        public DbSet<CaseMaterial> CaseMaterials { get; set; }
        public DbSet<CaseForm> CaseForms { get; set; }
        public DbSet<CaseSize> CaseSizes { get; set; }
        public DbSet<CaseColor> CaseColors { get; set; }
        public DbSet<ClockFace> ClockFaces { get; set; }
        public DbSet<NumberType> NumberTypes { get; set; }
        public DbSet<Backlight> Backlights { get; set; }
        public DbSet<Bracelet> Bracelets { get; set; }
        public DbSet<BraceletColor> BraceletColors { get; set; }
        public DbSet<Decoration> Decorations { get; set; }
        public DbSet<Additionall> Additionalls { get; set; }
        public DbSet<Watch> Watches { get; set; }
        #endregion
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            List<Brand> brands = new List<Brand>
            {
                new Brand(){ Name="6МХ"},
                new Brand(){ Name="Adriatica"},
                new Brand(){ Name="AGELOCER"},
                new Brand(){ Name="Alexander Shorokhoff"},
                new Brand(){ Name="Anne Klein"},
                new Brand(){ Name="Armand Nicolet"},
                new Brand(){ Name="Armani Exchange"},
                new Brand(){ Name="Aviator"},
                new Brand(){ Name="BALL"},
                new Brand(){ Name="Balmain"},
                new Brand(){ Name="Bauhaus"},
                new Brand(){ Name="Boccia Titanium"},
                new Brand(){ Name="Bomberg"},
                new Brand(){ Name="Breitling"},
                new Brand(){ Name="Briller"},
                new Brand(){ Name="Calvin Klein"},
                new Brand(){ Name="Candino"},
                new Brand(){ Name="Carl von Zeyten"},
                new Brand(){ Name="Casio"},
                new Brand(){ Name="Caviar"},
                new Brand(){ Name="Certina"},
                new Brand(){ Name="CIGA Design"},
                new Brand(){ Name="Citizen"},
                new Brand(){ Name="COACH"},
                new Brand(){ Name="Continental"},
                new Brand(){ Name="Cornavin"},
                new Brand(){ Name="Corum"},
                new Brand(){ Name="Cuervo y Sobrinos"},
                new Brand(){ Name="CVSTOS"},
                new Brand(){ Name="D1 Milano"},
                new Brand(){ Name="Daniel Klein"},
                new Brand(){ Name="Daniel Wellington"},
                new Brand(){ Name="DAVOSA"},
                new Brand(){ Name="Delbana"},
                new Brand(){ Name="Delma"},
                new Brand(){ Name="Diesel"},
                new Brand(){ Name="DKNY"},
                new Brand(){ Name="Doodle"},
                new Brand(){ Name="Ducati"},
                new Brand(){ Name="Elysee"},
                new Brand(){ Name="Emporio Armani"},
                new Brand(){ Name="Epos"},
                new Brand(){ Name="Festina"},
                new Brand(){ Name="Fossil"},
                new Brand(){ Name="Frederique Constant"},
                new Brand(){ Name="Freelook"},
                new Brand(){ Name="Furla"},
                new Brand(){ Name="Garmin"},
                new Brand(){ Name="Graham"},
                new Brand(){ Name="Grand Seiko"},
                new Brand(){ Name="Gucci"},
                new Brand(){ Name="Guess"},
                new Brand(){ Name="Guess Originals"},
                new Brand(){ Name="Hamilton"},
                new Brand(){ Name="HEAD"},
                new Brand(){ Name="HUBLOT"},
                new Brand(){ Name="HUGO"},
                new Brand(){ Name="Hugo Boss"},
                new Brand(){ Name="Ikepod"},
                new Brand(){ Name="Infantry"},
                new Brand(){ Name="Invicta"},
                new Brand(){ Name="Iron Annie"},
                new Brand(){ Name="Jacques Lemans"},
                new Brand(){ Name="Juicy Couture"},
                new Brand(){ Name="Just Cavalli"},
                new Brand(){ Name="Korloff"},
                new Brand(){ Name="Lacoste"},
                new Brand(){ Name="L Duchen"},
                new Brand(){ Name="Lee Cooper"},
                new Brand(){ Name="LIU JO"},
                new Brand(){ Name="Locman"},
                new Brand(){ Name="Longines"},
                new Brand(){ Name="Louis XVI"},
                new Brand(){ Name="Luminox"},
                new Brand(){ Name="M2Z"},
                new Brand(){ Name="Mathey-Tissot"},
                new Brand(){ Name="Maurice Lacroix"},
                new Brand(){ Name="Mazzucato"},
                new Brand(){ Name="Michael Kors"},
                new Brand(){ Name="Microwear"},
                new Brand(){ Name="Mido"},
                new Brand(){ Name="Mondaine"},
                new Brand(){ Name="MVMT"},
                new Brand(){ Name="Nautica"},
                new Brand(){ Name="NIKA"},
                new Brand(){ Name="NORQAIN"},
                new Brand(){ Name="Obaku"},
                new Brand(){ Name="Olivia Burton"},
                new Brand(){ Name="Orient"},
                new Brand(){ Name="Orient Star"},
                new Brand(){ Name="Perrelet"},
                new Brand(){ Name="Philipp Plein"},
                new Brand(){ Name="Pierre Ricaud"},
                new Brand(){ Name="PLEIN SPORT"},
                new Brand(){ Name="Poljot"},
                new Brand(){ Name="Rado"},
                new Brand(){ Name="Raymond Weil"},
                new Brand(){ Name="Rodania"},
                new Brand(){ Name="Rotary"},
                new Brand(){ Name="SAGA"},
                new Brand(){ Name="Salvatore Ferragamo"},
                new Brand(){ Name="Santa Barbara Polo &amp; Racquet Club"},
                new Brand(){ Name="Sector"},
                new Brand(){ Name="Seiko"},
                new Brand(){ Name="Sergio Tacchini"},
                new Brand(){ Name="Silvana"},
                new Brand(){ Name="Skagen"},
                new Brand(){ Name="SOKOLOV"},
                new Brand(){ Name="Stuhrling"},
                new Brand(){ Name="Suunto"},
                new Brand(){ Name="Swarovski"},
                new Brand(){ Name="Swatch"},
                new Brand(){ Name="Swiss Military Hanowa"},
                new Brand(){ Name="TAG Heuer"},
                new Brand(){ Name="TechnoMarine"},
                new Brand(){ Name="The Electricianz"},
                new Brand(){ Name="Thomas Sabo"},
                new Brand(){ Name="Timberland"},
                new Brand(){ Name="Timex"},
                new Brand(){ Name="Tissot"},
                new Brand(){ Name="Titoni"},
                new Brand(){ Name="Tommy Hilfiger"},
                new Brand(){ Name="TOUS"},
                new Brand(){ Name="Traser"},
                new Brand(){ Name="Tsar Bomba"},
                new Brand(){ Name="TSEDRO"},
                new Brand(){ Name="Venezianico"},
                new Brand(){ Name="Versace"},
                new Brand(){ Name="VERSUS Versace"},
                new Brand(){ Name="Victorinox"},
                new Brand(){ Name="VMF"},
                new Brand(){ Name="Wainer"},
                new Brand(){ Name="Wenger"},
                new Brand(){ Name="Zeppelin"},
                new Brand(){ Name="Восток"},
                new Brand(){ Name="Златоустовский часовой завод"},
                new Brand(){ Name="Михаил Москвин"},
                new Brand(){ Name="Молния"},
                new Brand(){ Name="Подарочные сертификаты"},
                new Brand(){ Name="Слава"},
                new Brand(){ Name="Специальное предложение"},
                new Brand(){ Name="Спецназ"},
                new Brand(){ Name="Штурманские"},
            };

            List<Country> countries = new List<Country>()
            {
                 new Country() {Name="Швейцария"},
                 new Country() {Name="Япония"},
                 new Country() {Name="Россия"},
                 new Country() {Name="Германия"},
                 new Country() {Name="Австрия"},
                 new Country() {Name="Бельгия"},
                 new Country() {Name="Великобритания"},
                 new Country() {Name="Гонконг"},
                 new Country() {Name="Дания"},
                 new Country() {Name="Испания"},
                 new Country() {Name="Италия"},
                 new Country() {Name="Китай"},
                 new Country() {Name="США"},
                 new Country() {Name="Турция"},
                 new Country() {Name="Финляндия"},
                 new Country() {Name="Франция"},
                 new Country() {Name="Швеция"},
                 new Country() {Name="Южная Корея"},
            };

            List<Style> styles = new List<Style>()
            {
                 new Style() {Name="Военные"},
                 new Style() {Name="Дизайнерские"},
                 new Style() {Name="Милитари"},
                 new Style() {Name="На каждый день"},
                 new Style() {Name="Пилотские"},
                 new Style() {Name="Под костюм"},
                 new Style() {Name="Спортивные"},
            };

            List<GlassType> glassTypes = new List<GlassType>
            {
                new GlassType() { Name="Минеральное" },
                new GlassType() { Name="Органическое" },
                new GlassType() { Name="Сапфировое" },
            };

            List<WaterResistant> waterResistants = new List<WaterResistant>()
            {
                 new WaterResistant() { Name="От 10WR"},
                 new WaterResistant() { Name="От 30WR"},
                 new WaterResistant() { Name="От 50WR"},
                 new WaterResistant() { Name="От 100WR"},
                 new WaterResistant() { Name="От 200WR"},
                 new WaterResistant() { Name="От 300WR"},
            };

            List<CaseMaterial> caseMaterials = new List<CaseMaterial>()
            {
                 new CaseMaterial() { Name="Металлический"},
                new CaseMaterial() { Name="Сталь"},
                new CaseMaterial() { Name="Титан"},
                new CaseMaterial() { Name="Золото"},
                new CaseMaterial() { Name="Желтое золото"},
                new CaseMaterial() { Name="Белое золото"},
                new CaseMaterial() { Name="Красное золото"},
                new CaseMaterial() { Name="Розовое золото"},
                new CaseMaterial() { Name="Серебро"},
                new CaseMaterial() { Name="Алюминий"},
                new CaseMaterial() { Name="Бронза"},
                new CaseMaterial() { Name="Карбон"},
                new CaseMaterial() { Name="Каучук"},
                new CaseMaterial() { Name="Керамический"},
                new CaseMaterial() { Name="Пластик"},
                new CaseMaterial() { Name="Резина"},
                new CaseMaterial() { Name="Силикон"},
            };

            List<CaseForm> caseForms = new List<CaseForm>()
            {
                new CaseForm() { Name="Бочка"},
                new CaseForm() { Name="Квадрат"},
                new CaseForm() { Name="Круг"},
                new CaseForm() { Name="Необычный"},
                new CaseForm() { Name="Овал"},
                new CaseForm() { Name="Прямоугольник"},
                new CaseForm() { Name="Треугольник"},
            };

            List<CaseSize> caseSizes = new List<CaseSize>()
            {
                new CaseSize() { Name="Большие" },
                new CaseSize() { Name="Тонкие" },
                new CaseSize() { Name="Маленькие" },
                new CaseSize() { Name="Стандартные" },
            };

            List<CaseColor> caseColors = new List<CaseColor>()
            {
                new CaseColor() { Name="Бежевый"},
                new CaseColor() { Name="Белый"},
                new CaseColor() { Name="Голубой"},
                new CaseColor() { Name="Двухцветный"},
                new CaseColor() { Name="Желтый"},
                new CaseColor() { Name="Зеленый"},
                new CaseColor() { Name="Коричневый"},
                new CaseColor() { Name="Красный"},
                new CaseColor() { Name="Оранжевый"},
                new CaseColor() { Name="Позолоченный"},
                new CaseColor() { Name="Прозрачный"},
                new CaseColor() { Name="Разноцветные"},
                new CaseColor() { Name="Розовый"},
                new CaseColor() { Name="Серый"},
                new CaseColor() { Name="Синий"},
                new CaseColor() { Name="Фиолетовый"},
                new CaseColor() { Name="Черный"},
            };

            List<ClockFace> clockFaces = new List<ClockFace>()
            {
                new ClockFace() { Name="Комбинированный"},
                new ClockFace() { Name="Стрелочный"},
                new ClockFace() { Name="Цифровой"},
            };

            List<NumberType> numberTypes = new List<NumberType>()
            {
                new NumberType() { Name="Арабские" },
                new NumberType() { Name="Без меток" },
                new NumberType() { Name="Римские" },
                new NumberType() { Name="Точки" },
                new NumberType() { Name="Штрихи" },
            };

            List<Backlight> backlights = new List<Backlight>()
            {
                new Backlight() { Name="Люминесцентная"},
                new Backlight() { Name="Тритиевая"},
                new Backlight() { Name="Электрическая"},
            };

            List<Bracelet> bracelets = new List<Bracelet>()
            {
                new Bracelet() { Name="Браслет"},
                new Bracelet() { Name="Резина/пластик"},
                new Bracelet() { Name="Кожа/текстиль"},
                new Bracelet() { Name="Алюминиевый"},
                new Bracelet() { Name="Атласный"},
                new Bracelet() { Name="Джинсовый"},
                new Bracelet() { Name="Карбоновый"},
                new Bracelet() { Name="Каучуковый"},
                new Bracelet() { Name="Керамический"},
                new Bracelet() { Name="Кожаный"},
                new Bracelet() { Name="Миланский"},
                new Bracelet() { Name="Нейлоновый"},
                new Bracelet() { Name="Пластиковый"},
                new Bracelet() { Name="Полиуретановый"},
                new Bracelet() { Name="Резиновый"},
                new Bracelet() { Name="Серебряный"},
                new Bracelet() { Name="Силиконовый"},
                new Bracelet() { Name="Стальной"},
                new Bracelet() { Name="Текстильный"},
                new Bracelet() { Name="Титановый"},
                new Bracelet() { Name="Тканевый"},
            };

            List<BraceletColor> braceletColors = new List<BraceletColor>()
            {
                new BraceletColor() {Name="Бежевый"},
                new BraceletColor() {Name="Белый"},
                new BraceletColor() {Name="Голубой"},
                new BraceletColor() {Name="Двухцветный"},
                new BraceletColor() {Name="Желтый"},
                new BraceletColor() {Name="Зеленый"},
                new BraceletColor() {Name="Коричневый"},
                new BraceletColor() {Name="Красный"},
                new BraceletColor() {Name="Оранжевый"},
                new BraceletColor() {Name="Прозрачный"},
                new BraceletColor() {Name="Разноцветные"},
                new BraceletColor() {Name="Розовый"},
                new BraceletColor() {Name="Серый"},
                new BraceletColor() {Name="Синий"},
                new BraceletColor() {Name="Фиолетовый"},
                new BraceletColor() {Name="Черный"},
            };

            List<Decoration> decorations = new List<Decoration>()
            {
                new Decoration() { Name="Аметисты"},
                new Decoration() { Name="Бриллианты"},
                new Decoration() { Name="Вставки из золота"},
                new Decoration() { Name="Вставки из пластика"},
                new Decoration() { Name="Вставки керамические"},
                new Decoration() { Name="Жемчуг"},
                new Decoration() { Name="Кристаллы Swarovski"},
                new Decoration() { Name="Рубины"},
                new Decoration() { Name="Сапфиры"},
                new Decoration() { Name="Топазы"},
                new Decoration() { Name="Фианиты"},
                new Decoration() { Name="Хрусталь"},
                new Decoration() { Name="Цирконы"},
                new Decoration() { Name="Эмаль"},
                new Decoration() { Name="Янтарь"},
            };

            List<Additionall> additionalls = new List<Additionall>()
            {
                new Additionall() { Name="GPS-навигаторы"},
                new Additionall() { Name="Большая дата"},
                new Additionall() { Name="Вечный календарь"},
                new Additionall() { Name="Есть парная модель"},
                new Additionall() { Name="Карманные"},
                new Additionall() { Name="Лимитированная серия"},
                new Additionall() { Name="Мировое время"},
                new Additionall() { Name="Приливы-отливы"},
                new Additionall() { Name="Противоударные"},
                new Additionall() { Name="Пульсометры"},
                new Additionall() { Name="С барометром"},
                new Additionall() { Name="С будильником"},
                new Additionall() { Name="С высотомером"},
                new Additionall() { Name="Связь с мобильным телефоном"},
                new Additionall() { Name="С глубиномером"},
                new Additionall() { Name="Сердечный ритм"},
                new Additionall() { Name="С измерением калорий"},
                new Additionall() { Name="С календарем"},
                new Additionall() { Name="Скелетоны"},
                new Additionall() { Name="С компасом"},
                new Additionall() { Name="С лунным календарем"},
                new Additionall() { Name="С секундомером"},
                new Additionall() { Name="С термометром"},
                new Additionall() { Name="Хронографы"},
                new Additionall() { Name="Хронометры"},
                new Additionall() { Name="Шагомер"},
            };

            modelBuilder.Entity<Brand>().HasData(brands);
            modelBuilder.Entity<Country>().HasData(countries);
            modelBuilder.Entity<Style>().HasData(styles);
            modelBuilder.Entity<GlassType>().HasData(glassTypes);
            modelBuilder.Entity<WaterResistant>().HasData(waterResistants);
            modelBuilder.Entity<CaseMaterial>().HasData(caseMaterials);
            modelBuilder.Entity<CaseForm>().HasData(caseForms);
            modelBuilder.Entity<CaseSize>().HasData(caseSizes);
            modelBuilder.Entity<CaseColor>().HasData(caseColors);
            modelBuilder.Entity<ClockFace>().HasData(clockFaces);
            modelBuilder.Entity<NumberType>().HasData(numberTypes);
            modelBuilder.Entity<Backlight>().HasData(backlights);
            modelBuilder.Entity<Bracelet>().HasData(bracelets);
            modelBuilder.Entity<BraceletColor>().HasData(braceletColors);
            modelBuilder.Entity<Decoration>().HasData(decorations);
            modelBuilder.Entity<Additionall>().HasData(additionalls);
        }
    }
}
