using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace Coursach.Migrations
{
    /// <inheritdoc />
    public partial class init : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterDatabase()
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "Additionalls",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci"),
                    Name = table.Column<string>(type: "longtext", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Additionalls", x => x.Id);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "AspNetRoles",
                columns: table => new
                {
                    Id = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Name = table.Column<string>(type: "varchar(256)", maxLength: 256, nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    NormalizedName = table.Column<string>(type: "varchar(256)", maxLength: 256, nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    ConcurrencyStamp = table.Column<string>(type: "longtext", nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetRoles", x => x.Id);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "AspNetUsers",
                columns: table => new
                {
                    Id = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    UserName = table.Column<string>(type: "varchar(256)", maxLength: 256, nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    NormalizedUserName = table.Column<string>(type: "varchar(256)", maxLength: 256, nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Email = table.Column<string>(type: "varchar(256)", maxLength: 256, nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    NormalizedEmail = table.Column<string>(type: "varchar(256)", maxLength: 256, nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    EmailConfirmed = table.Column<bool>(type: "tinyint(1)", nullable: false),
                    PasswordHash = table.Column<string>(type: "longtext", nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    SecurityStamp = table.Column<string>(type: "longtext", nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    ConcurrencyStamp = table.Column<string>(type: "longtext", nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    PhoneNumber = table.Column<string>(type: "longtext", nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    PhoneNumberConfirmed = table.Column<bool>(type: "tinyint(1)", nullable: false),
                    TwoFactorEnabled = table.Column<bool>(type: "tinyint(1)", nullable: false),
                    LockoutEnd = table.Column<DateTimeOffset>(type: "datetime(6)", nullable: true),
                    LockoutEnabled = table.Column<bool>(type: "tinyint(1)", nullable: false),
                    AccessFailedCount = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetUsers", x => x.Id);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "Backlights",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci"),
                    Name = table.Column<string>(type: "longtext", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Backlights", x => x.Id);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "BraceletColors",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci"),
                    Name = table.Column<string>(type: "longtext", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_BraceletColors", x => x.Id);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "Bracelets",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci"),
                    Name = table.Column<string>(type: "longtext", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Bracelets", x => x.Id);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "Brands",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci"),
                    Name = table.Column<string>(type: "longtext", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Brands", x => x.Id);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "CaseColors",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci"),
                    Name = table.Column<string>(type: "longtext", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CaseColors", x => x.Id);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "CaseForms",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci"),
                    Name = table.Column<string>(type: "longtext", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CaseForms", x => x.Id);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "CaseMaterials",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci"),
                    Name = table.Column<string>(type: "longtext", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CaseMaterials", x => x.Id);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "CaseSizes",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci"),
                    Name = table.Column<string>(type: "longtext", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CaseSizes", x => x.Id);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "ClockFaces",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci"),
                    Name = table.Column<string>(type: "longtext", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ClockFaces", x => x.Id);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "Countries",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci"),
                    Name = table.Column<string>(type: "longtext", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Countries", x => x.Id);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "Decorations",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci"),
                    Name = table.Column<string>(type: "longtext", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Decorations", x => x.Id);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "GlassTypes",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci"),
                    Name = table.Column<string>(type: "longtext", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_GlassTypes", x => x.Id);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "NumberTypes",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci"),
                    Name = table.Column<string>(type: "longtext", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_NumberTypes", x => x.Id);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "Styles",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci"),
                    Name = table.Column<string>(type: "longtext", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Styles", x => x.Id);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "WaterResistants",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci"),
                    Name = table.Column<string>(type: "longtext", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_WaterResistants", x => x.Id);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "AspNetRoleClaims",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    RoleId = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    ClaimType = table.Column<string>(type: "longtext", nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    ClaimValue = table.Column<string>(type: "longtext", nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetRoleClaims", x => x.Id);
                    table.ForeignKey(
                        name: "FK_AspNetRoleClaims_AspNetRoles_RoleId",
                        column: x => x.RoleId,
                        principalTable: "AspNetRoles",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "AspNetUserClaims",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    UserId = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    ClaimType = table.Column<string>(type: "longtext", nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    ClaimValue = table.Column<string>(type: "longtext", nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetUserClaims", x => x.Id);
                    table.ForeignKey(
                        name: "FK_AspNetUserClaims_AspNetUsers_UserId",
                        column: x => x.UserId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "AspNetUserLogins",
                columns: table => new
                {
                    LoginProvider = table.Column<string>(type: "varchar(128)", maxLength: 128, nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    ProviderKey = table.Column<string>(type: "varchar(128)", maxLength: 128, nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    ProviderDisplayName = table.Column<string>(type: "longtext", nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    UserId = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetUserLogins", x => new { x.LoginProvider, x.ProviderKey });
                    table.ForeignKey(
                        name: "FK_AspNetUserLogins_AspNetUsers_UserId",
                        column: x => x.UserId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "AspNetUserRoles",
                columns: table => new
                {
                    UserId = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    RoleId = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetUserRoles", x => new { x.UserId, x.RoleId });
                    table.ForeignKey(
                        name: "FK_AspNetUserRoles_AspNetRoles_RoleId",
                        column: x => x.RoleId,
                        principalTable: "AspNetRoles",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_AspNetUserRoles_AspNetUsers_UserId",
                        column: x => x.UserId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "AspNetUserTokens",
                columns: table => new
                {
                    UserId = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    LoginProvider = table.Column<string>(type: "varchar(128)", maxLength: 128, nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Name = table.Column<string>(type: "varchar(128)", maxLength: 128, nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Value = table.Column<string>(type: "longtext", nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetUserTokens", x => new { x.UserId, x.LoginProvider, x.Name });
                    table.ForeignKey(
                        name: "FK_AspNetUserTokens_AspNetUsers_UserId",
                        column: x => x.UserId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "Watches",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci"),
                    ModelName = table.Column<string>(type: "longtext", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    IsFavorite = table.Column<bool>(type: "tinyint(1)", nullable: false),
                    Count = table.Column<uint>(type: "int unsigned", nullable: false),
                    Genre = table.Column<int>(type: "int", nullable: false),
                    Price = table.Column<float>(type: "float", nullable: false),
                    Description = table.Column<string>(type: "longtext", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    BrandId = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci"),
                    CountryId = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci"),
                    StyleId = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci"),
                    Mechanism = table.Column<int>(type: "int", nullable: false),
                    GlassTypeId = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci"),
                    WaterResistantId = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci"),
                    CaseMaterialId = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci"),
                    CaseFormId = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci"),
                    CaseSizeId = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci"),
                    CaseColorId = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci"),
                    ClockFaceId = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci"),
                    NumberTypeId = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci"),
                    BacklightId = table.Column<Guid>(type: "char(36)", nullable: true, collation: "ascii_general_ci"),
                    BraceletId = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci"),
                    BraceletColorId = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci"),
                    Bytes = table.Column<byte[]>(type: "longblob", nullable: false),
                    FileExtension = table.Column<string>(type: "longtext", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Size = table.Column<decimal>(type: "decimal(65,30)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Watches", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Watches_Backlights_BacklightId",
                        column: x => x.BacklightId,
                        principalTable: "Backlights",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Watches_BraceletColors_BraceletColorId",
                        column: x => x.BraceletColorId,
                        principalTable: "BraceletColors",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Watches_Bracelets_BraceletId",
                        column: x => x.BraceletId,
                        principalTable: "Bracelets",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Watches_Brands_BrandId",
                        column: x => x.BrandId,
                        principalTable: "Brands",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Watches_CaseColors_CaseColorId",
                        column: x => x.CaseColorId,
                        principalTable: "CaseColors",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Watches_CaseForms_CaseFormId",
                        column: x => x.CaseFormId,
                        principalTable: "CaseForms",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Watches_CaseMaterials_CaseMaterialId",
                        column: x => x.CaseMaterialId,
                        principalTable: "CaseMaterials",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Watches_CaseSizes_CaseSizeId",
                        column: x => x.CaseSizeId,
                        principalTable: "CaseSizes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Watches_ClockFaces_ClockFaceId",
                        column: x => x.ClockFaceId,
                        principalTable: "ClockFaces",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Watches_Countries_CountryId",
                        column: x => x.CountryId,
                        principalTable: "Countries",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Watches_GlassTypes_GlassTypeId",
                        column: x => x.GlassTypeId,
                        principalTable: "GlassTypes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Watches_NumberTypes_NumberTypeId",
                        column: x => x.NumberTypeId,
                        principalTable: "NumberTypes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Watches_Styles_StyleId",
                        column: x => x.StyleId,
                        principalTable: "Styles",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Watches_WaterResistants_WaterResistantId",
                        column: x => x.WaterResistantId,
                        principalTable: "WaterResistants",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "AdditionallWatch",
                columns: table => new
                {
                    AdditionallsId = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci"),
                    WatchesId = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AdditionallWatch", x => new { x.AdditionallsId, x.WatchesId });
                    table.ForeignKey(
                        name: "FK_AdditionallWatch_Additionalls_AdditionallsId",
                        column: x => x.AdditionallsId,
                        principalTable: "Additionalls",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_AdditionallWatch_Watches_WatchesId",
                        column: x => x.WatchesId,
                        principalTable: "Watches",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "DecorationWatch",
                columns: table => new
                {
                    DecorationsId = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci"),
                    WatchesId = table.Column<Guid>(type: "char(36)", nullable: false, collation: "ascii_general_ci")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DecorationWatch", x => new { x.DecorationsId, x.WatchesId });
                    table.ForeignKey(
                        name: "FK_DecorationWatch_Decorations_DecorationsId",
                        column: x => x.DecorationsId,
                        principalTable: "Decorations",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_DecorationWatch_Watches_WatchesId",
                        column: x => x.WatchesId,
                        principalTable: "Watches",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.InsertData(
                table: "Additionalls",
                columns: new[] { "Id", "Name" },
                values: new object[,]
                {
                    { new Guid("09ea59d4-3be0-4d2a-b4bc-b0cab5af5ad4"), "С календарем" },
                    { new Guid("1af44a1f-2d4c-43bf-8cb7-4a665e16f9a5"), "С глубиномером" },
                    { new Guid("1e33e05f-dbd5-4b4f-9a79-7934adcbf057"), "Хронометры" },
                    { new Guid("232d9bed-c5d7-4753-929c-53be17c52eb0"), "С будильником" },
                    { new Guid("2d990ad0-bda5-4b60-95f3-13c2d4dae5b0"), "Скелетоны" },
                    { new Guid("3845df03-a237-4a3b-89dd-be36f823242d"), "С измерением калорий" },
                    { new Guid("4da68d9b-c846-4802-b769-e745c5bc7354"), "Пульсометры" },
                    { new Guid("58ed6caf-7232-4058-a4a2-a5824b5995c8"), "С компасом" },
                    { new Guid("692c12df-d684-4e92-ba29-0595688954d9"), "Мировое время" },
                    { new Guid("69e1e9ac-ab0e-4bf7-a7a2-c719b1817029"), "Большая дата" },
                    { new Guid("6a91b4ed-539f-43fa-a86c-132d79f1c4c6"), "Связь с мобильным телефоном" },
                    { new Guid("6b373711-eb90-4beb-93f1-81b990f348d5"), "GPS-навигаторы" },
                    { new Guid("76328ced-f420-47a4-9ca0-fe5fbbede3e0"), "Хронографы" },
                    { new Guid("78a9cadc-99e4-4b6b-b665-2c3b80d7e30c"), "Противоударные" },
                    { new Guid("8842855f-f5f4-4b70-b6bc-69f706baaacb"), "С высотомером" },
                    { new Guid("9038a6f2-c0c3-4fa8-9910-dcbb993fddd9"), "Приливы-отливы" },
                    { new Guid("960c85cc-7ec3-460c-95e7-ae768970a65c"), "Карманные" },
                    { new Guid("991ed83d-3ff7-43e8-ae0e-516dceb29424"), "С лунным календарем" },
                    { new Guid("9d085e9a-6daf-4afe-b9e3-5c81117e8a63"), "С термометром" },
                    { new Guid("a83e4a87-413b-490c-937f-36bc4e9f7332"), "Шагомер" },
                    { new Guid("cc16f66c-8da3-42e8-b00e-c6f04d31eea4"), "С секундомером" },
                    { new Guid("cd84eee4-9da6-4e4d-a7cb-ea3b061e1c58"), "С барометром" },
                    { new Guid("d69cdcbe-797d-4363-8954-74fe8b1d242b"), "Лимитированная серия" },
                    { new Guid("e119fc7f-0c71-4334-b87b-ca8dd92c1cbc"), "Сердечный ритм" },
                    { new Guid("ed601b75-e976-4306-a9ea-4b2ecb1aaeb9"), "Есть парная модель" },
                    { new Guid("ef24a2a1-e467-4529-ab07-b25688c23df7"), "Вечный календарь" }
                });

            migrationBuilder.InsertData(
                table: "Backlights",
                columns: new[] { "Id", "Name" },
                values: new object[,]
                {
                    { new Guid("6210bd6a-1b01-4178-9c0a-dd934892d201"), "Тритиевая" },
                    { new Guid("86f3107a-25df-40cd-ab80-df0bf225bcf4"), "Электрическая" },
                    { new Guid("a8735cf0-249d-43fd-b015-f3b6e722299f"), "Люминесцентная" }
                });

            migrationBuilder.InsertData(
                table: "BraceletColors",
                columns: new[] { "Id", "Name" },
                values: new object[,]
                {
                    { new Guid("02154ecb-4b88-4002-a87c-afdbfe12c835"), "Зеленый" },
                    { new Guid("19622a60-fff5-4abb-b083-590d3d8aca12"), "Коричневый" },
                    { new Guid("22562f38-d8f5-4894-a614-d4ad3c33cb2e"), "Фиолетовый" },
                    { new Guid("2cabb56c-8eaf-4af1-ada7-bab50726a83b"), "Желтый" },
                    { new Guid("3d4a5fcf-1adb-40e4-b272-a0b129a9ab97"), "Прозрачный" },
                    { new Guid("59a54385-6c17-499e-9388-95e53b29e506"), "Черный" },
                    { new Guid("7dbc57dc-7efa-4f6c-93e2-4412d9f9c896"), "Красный" },
                    { new Guid("87af60fe-1dc7-49ba-bccc-d2c201882f82"), "Белый" },
                    { new Guid("92169422-9f15-4101-abbf-52936e9def82"), "Двухцветный" },
                    { new Guid("9777f626-8f4f-4d12-bc79-66522e839486"), "Разноцветные" },
                    { new Guid("b11c5ac2-b105-463f-b415-c1f29962743c"), "Серый" },
                    { new Guid("b5396349-1d2a-467b-851b-3d5a411b5dd6"), "Оранжевый" },
                    { new Guid("b93d413f-4fc0-4dd8-a778-69d1fe3fe275"), "Бежевый" },
                    { new Guid("c8d7727a-c709-450b-bd6f-d3fa0d7e78af"), "Розовый" },
                    { new Guid("e9b60471-95ea-4c4f-afe0-0770a3525924"), "Голубой" },
                    { new Guid("f8ca1883-f3cf-4ee3-b3d5-a94447e8b5f9"), "Синий" }
                });

            migrationBuilder.InsertData(
                table: "Bracelets",
                columns: new[] { "Id", "Name" },
                values: new object[,]
                {
                    { new Guid("037622fc-71bb-475a-ba8d-657e4beb719c"), "Миланский" },
                    { new Guid("08a4da26-56d2-4686-a082-db7878e52e1a"), "Стальной" },
                    { new Guid("0b7e3f22-21d8-4ffa-8316-5f744ee353bb"), "Резина/пластик" },
                    { new Guid("1e4c6f0c-893f-46bb-910a-0b545baf9230"), "Нейлоновый" },
                    { new Guid("3a386075-8faa-4908-9ce2-ac102318751c"), "Керамический" },
                    { new Guid("414ba004-3156-4a4a-a8d1-f93c34282dbb"), "Титановый" },
                    { new Guid("54860f49-a3f2-4b3c-b712-86969bf8cd54"), "Текстильный" },
                    { new Guid("6c73b63d-472e-44e7-a5af-6a3f3786d7e3"), "Силиконовый" },
                    { new Guid("6cea87ac-bc64-44d8-ad08-a48e10bb6073"), "Карбоновый" },
                    { new Guid("7404b58c-ee5a-4420-9770-26d0157bb7d3"), "Резиновый" },
                    { new Guid("a3b7dde3-4255-4fe7-b29c-a413828e042d"), "Браслет" },
                    { new Guid("a85630cd-5931-4563-9837-f9a26b47c1d2"), "Каучуковый" },
                    { new Guid("acc1c286-cdf7-4597-b8c4-15c37642c318"), "Серебряный" },
                    { new Guid("bf95ba78-41da-4ecd-af33-d36b51164ec2"), "Пластиковый" },
                    { new Guid("c3057c2c-cbf0-403e-a296-e5e8a927b277"), "Атласный" },
                    { new Guid("c6714173-35d4-4783-a2e6-b6b3c3721490"), "Кожаный" },
                    { new Guid("cb84bcd7-c712-42cd-beb4-7e34f3976396"), "Кожа/текстиль" },
                    { new Guid("d13e2ed2-cdbc-41a6-9f9b-6d26ed076337"), "Джинсовый" },
                    { new Guid("df8ec533-6c45-49a8-917c-6e32ee7be056"), "Алюминиевый" },
                    { new Guid("ec82ddfa-0375-4225-80c5-f6a35ffb681e"), "Тканевый" },
                    { new Guid("f1043b75-6715-4b22-9ac4-1539e42cd7b3"), "Полиуретановый" }
                });

            migrationBuilder.InsertData(
                table: "Brands",
                columns: new[] { "Id", "Name" },
                values: new object[,]
                {
                    { new Guid("00e9bb7d-e23b-4aa4-b01b-175e76fafa39"), "Nautica" },
                    { new Guid("022c2a79-832f-45f0-b197-c7e58aef3d62"), "Elysee" },
                    { new Guid("09b290be-39f9-4428-80ab-e4ffc8e9cd18"), "Emporio Armani" },
                    { new Guid("09c93776-a50e-4acb-830e-1d03c7abfe81"), "Titoni" },
                    { new Guid("0a3c2fd8-34d1-42c3-bec6-3ac8f85f88f1"), "Caviar" },
                    { new Guid("0b6ce130-4e23-450f-ba76-d4ada116e3c0"), "SAGA" },
                    { new Guid("0e0a08b3-9e02-4506-8a5a-054bdadad1b2"), "Longines" },
                    { new Guid("0feeebfd-bb8e-4402-aafb-f008dfc2ec58"), "Rodania" },
                    { new Guid("15477b61-4a67-497e-b861-3c8b8da07408"), "Armani Exchange" },
                    { new Guid("156f4213-962b-4349-8e5c-471316d1b49e"), "Штурманские" },
                    { new Guid("18e80a3b-a078-48a3-b234-eb35889cc91c"), "TAG Heuer" },
                    { new Guid("1910903b-015a-4c2c-9c89-ee1c8805379f"), "Skagen" },
                    { new Guid("1c11ce64-5eca-4b25-b8a0-21ef5bb50b10"), "Fossil" },
                    { new Guid("21cbd939-c689-4b4a-ab80-2d1324dc20ff"), "Rado" },
                    { new Guid("2216fbc5-1633-48ab-a01c-173ebaad3688"), "Freelook" },
                    { new Guid("2240bbc8-5164-43ad-93ab-e7da9ec20387"), "Traser" },
                    { new Guid("2991fe97-bb39-4e92-ba4c-1d5c9e227497"), "Louis XVI" },
                    { new Guid("2cb3adaa-3b3b-497e-abc9-fcb4b32f8117"), "Pierre Ricaud" },
                    { new Guid("2f3e587b-2649-450f-9aab-528d82dd996b"), "Rotary" },
                    { new Guid("2fa3180a-1d23-42af-b13d-eb5e2089bb1b"), "HUBLOT" },
                    { new Guid("2fc091a3-5325-453f-9d9e-db491a3add8f"), "Frederique Constant" },
                    { new Guid("34a46f19-b5df-4b09-9e1d-c55bb4b3b3e4"), "TechnoMarine" },
                    { new Guid("3618b8a7-b972-4e63-895b-adba6f90dbe9"), "NORQAIN" },
                    { new Guid("370a1b8e-9fa1-439d-a148-d511879fc787"), "Swarovski" },
                    { new Guid("37eafcaf-3189-43bf-bca7-3f0468c26960"), "Gucci" },
                    { new Guid("381193cb-d65f-48e8-907d-c72f4937c167"), "Infantry" },
                    { new Guid("39074783-8261-4345-86d1-56800c7e696c"), "Invicta" },
                    { new Guid("39e22a47-e30a-4b35-9289-a8e39361a55e"), "Diesel" },
                    { new Guid("3c030fdc-1656-47c5-9a06-acdcb02f8ea1"), "COACH" },
                    { new Guid("3f1684c6-5912-45b6-8149-cffc996b39ee"), "CVSTOS" },
                    { new Guid("3fbf5e0d-2b88-4f31-897c-6410e30032ef"), "Adriatica" },
                    { new Guid("43e61397-ce33-419a-a402-e19f58cea649"), "Victorinox" },
                    { new Guid("46bd4c84-2911-49d8-9fe7-837017765805"), "Festina" },
                    { new Guid("4991a14a-4e7d-4948-9e3a-ad40cc2279b8"), "Salvatore Ferragamo" },
                    { new Guid("4dbc2dea-3f6b-4607-bdc7-6d52970bc0f4"), "Briller" },
                    { new Guid("4eb49b7b-9cef-4254-a0ca-bf2b478c1455"), "DKNY" },
                    { new Guid("4ee9639b-355b-427e-8722-fe7f41c6127b"), "D1 Milano" },
                    { new Guid("4f346fa2-172d-408a-b23d-49bb1535a48f"), "Специальное предложение" },
                    { new Guid("512c974d-b5a7-41c4-8964-ae3adcda9709"), "Tissot" },
                    { new Guid("53080c0f-adc1-46d4-8346-f711d6862708"), "Михаил Москвин" },
                    { new Guid("5320a73c-20db-44a4-8837-feacd7b751b0"), "Lacoste" },
                    { new Guid("5397f264-ca56-4d21-927e-94f2cf402aa0"), "Tsar Bomba" },
                    { new Guid("53f01fa2-fa41-4d19-8dd2-255de03ea089"), "Venezianico" },
                    { new Guid("54d5ae48-b6b9-4ad0-ad44-16ffc6f13314"), "Daniel Klein" },
                    { new Guid("552fab6b-3a83-4b4c-89c6-b2f0f83eb2de"), "Mathey-Tissot" },
                    { new Guid("56118fef-d066-4f65-b2b1-d736adc8fee4"), "Philipp Plein" },
                    { new Guid("5690032d-0f9c-49b9-8266-bbd266d1a22d"), "Maurice Lacroix" },
                    { new Guid("57d5b468-72c9-4408-87ee-8d602b8ebde2"), "TOUS" },
                    { new Guid("598530ed-47fc-4c27-933f-df95fbc36611"), "Balmain" },
                    { new Guid("5aca5967-67fb-437f-8662-ad38ee885316"), "Obaku" },
                    { new Guid("5af06b39-d1ba-4e5a-85a2-f408d617c58d"), "Boccia Titanium" },
                    { new Guid("5bfaa9a1-9cf4-42b1-bda5-33c587501b1d"), "Tommy Hilfiger" },
                    { new Guid("5c0647be-7606-4595-9a6b-db8bc9efda66"), "Santa Barbara Polo &amp; Racquet Club" },
                    { new Guid("5cc49c9a-ed35-4ead-a0fe-ab1d76460207"), "Orient Star" },
                    { new Guid("5d035a10-3874-48f6-96e4-9507762a1532"), "AGELOCER" },
                    { new Guid("5d253915-b90f-4663-98cf-b1641af67c83"), "Восток" },
                    { new Guid("620b4580-56f1-48fe-b8a9-b621df14535f"), "Breitling" },
                    { new Guid("6ba40d86-7def-4429-aafc-5b188ebf9c53"), "Mido" },
                    { new Guid("6c283026-4755-4878-948d-dcb5e96df6fe"), "Olivia Burton" },
                    { new Guid("706d951d-c6f2-4b22-bc6f-6dd6dc60a1ce"), "TSEDRO" },
                    { new Guid("71f57d49-79f7-40b5-9585-4f76dd6258fc"), "Lee Cooper" },
                    { new Guid("720029a8-b506-4925-ad4a-d70bdc45c2b6"), "LIU JO" },
                    { new Guid("724bad9c-11eb-4284-b436-3ac73b333814"), "Raymond Weil" },
                    { new Guid("72b5d02b-9015-4ad7-84c8-f971d8963130"), "Microwear" },
                    { new Guid("73d83462-bd50-4235-b0a1-18e6e4ad4841"), "Perrelet" },
                    { new Guid("7593afb9-d7b3-4ae2-ab56-3d11efc7fcae"), "VERSUS Versace" },
                    { new Guid("770a66bf-9a87-49a7-af70-f9bf3347e669"), "Hamilton" },
                    { new Guid("77c7ad68-6365-4e4e-87b3-ddd513ca4281"), "Wainer" },
                    { new Guid("790fd10f-890e-4165-b4ed-9c929cb0dfea"), "L Duchen" },
                    { new Guid("7a3b9e5e-5c1b-4e72-87a9-2d7e9d7e2908"), "Слава" },
                    { new Guid("7c8e81b0-8df3-4eb7-88ac-e168d8c77f56"), "Anne Klein" },
                    { new Guid("7daf3a97-4117-453d-9c4c-e86ac0abd69a"), "PLEIN SPORT" },
                    { new Guid("7ea72226-7054-4dff-928a-431fdab74d8e"), "Garmin" },
                    { new Guid("8309fd3a-8152-4be1-be2a-e7089340f5aa"), "Подарочные сертификаты" },
                    { new Guid("843770d0-ae69-4836-ae18-7556e79d497a"), "Doodle" },
                    { new Guid("858cee13-df35-426a-9d51-3029eec4d210"), "HUGO" },
                    { new Guid("8a4d1c7b-c2b0-449a-abfa-3b117ffbfb97"), "Sergio Tacchini" },
                    { new Guid("8f74917f-e5ba-45a8-b0c9-05dc3b5ce6b2"), "Swatch" },
                    { new Guid("917d856a-fe8e-4455-a300-72da7de2b362"), "Sector" },
                    { new Guid("919c7921-a856-4086-a177-17581f8346d5"), "Daniel Wellington" },
                    { new Guid("9348c534-e6bf-4ace-9cfe-70be570b6bac"), "Silvana" },
                    { new Guid("94441187-c720-43d9-b93a-837d909abc15"), "Delbana" },
                    { new Guid("95ccb13e-51db-4b5b-b5aa-2464bc32ec23"), "Ducati" },
                    { new Guid("9663c31b-d637-476f-81ad-505386a4dfa4"), "BALL" },
                    { new Guid("970e93dd-4343-44a8-9349-2f01629be0cd"), "Epos" },
                    { new Guid("971034fc-c1e6-4793-8589-76d4ff86e64a"), "Delma" },
                    { new Guid("9a142f1d-ebb4-4509-b1a0-d98fdba4aad8"), "Златоустовский часовой завод" },
                    { new Guid("9e57e508-a538-4391-81f8-40d915b568b9"), "Orient" },
                    { new Guid("9f08a518-f4b7-4ab7-a260-837445a2a238"), "Jacques Lemans" },
                    { new Guid("a11455c1-4e8d-49d7-981c-f6d4dadfea49"), "6МХ" },
                    { new Guid("a4f2348e-d3a6-417a-89c3-c2fd5352ea26"), "Continental" },
                    { new Guid("a745e485-242c-4230-bd83-c6102dab9e23"), "Timex" },
                    { new Guid("a9f95b91-d7cd-4631-ae8f-25d0c6a5f154"), "Juicy Couture" },
                    { new Guid("acb5e4f4-97cd-49d9-af90-1ac7ce9de143"), "Cornavin" },
                    { new Guid("af3580a9-d5a8-4a47-b75f-93b42942ffeb"), "Молния" },
                    { new Guid("b34abb86-02e5-4a21-acf1-c395a86cb074"), "Seiko" },
                    { new Guid("b34bd48e-d1b0-4afc-8487-02e733627cf7"), "Suunto" },
                    { new Guid("b40e0605-5fa3-4d55-9c68-56d328596cc9"), "DAVOSA" },
                    { new Guid("b5719415-2b49-40f2-8761-9a7ec442898f"), "Michael Kors" },
                    { new Guid("b69db020-37d2-4c86-b7a7-9e5d62f0647d"), "MVMT" },
                    { new Guid("b8303bb8-25e0-4110-8179-d05e1563d1c9"), "SOKOLOV" },
                    { new Guid("b843f1a9-50b6-47da-a087-d0b82982f23a"), "Ikepod" },
                    { new Guid("b8beb783-c0cb-4fe2-843e-00db8669825e"), "Alexander Shorokhoff" },
                    { new Guid("bd318db2-5bca-403b-ae2c-847df9ed6e57"), "Furla" },
                    { new Guid("be720237-40ab-4574-b82b-a649a28888ea"), "Zeppelin" },
                    { new Guid("bf6cb674-d63e-4f60-9081-ac9dd84c7450"), "Iron Annie" },
                    { new Guid("c0f81b7e-ce3f-4b3c-a9e4-245dc7cbe8cd"), "Luminox" },
                    { new Guid("c3d730c1-b163-4e93-a64e-1ae5f6a6612c"), "Armand Nicolet" },
                    { new Guid("c422e826-870e-4475-ae13-d6c15eb404a6"), "Stuhrling" },
                    { new Guid("c7d5eaa6-aea3-45d7-a27d-5a1b4ee005b3"), "CIGA Design" },
                    { new Guid("c7f53d50-fa41-4c17-8920-7027611f152f"), "Poljot" },
                    { new Guid("cafc109e-a128-4a25-9209-bfd1cf8e3fdc"), "Casio" },
                    { new Guid("ccd67fb4-9d6b-4a84-ae2a-5517903e2ed7"), "Timberland" },
                    { new Guid("cd3b79c3-0e4c-4c34-b08d-39960067db22"), "Hugo Boss" },
                    { new Guid("d0e2a987-12ad-4d46-a165-05a6f4aeae70"), "The Electricianz" },
                    { new Guid("d1c5b624-fc54-4520-b1a9-d43bd6a66560"), "Bomberg" },
                    { new Guid("d3583ef5-814b-4ebf-9fc8-3541036a90c8"), "M2Z" },
                    { new Guid("d4873979-725e-4419-b8d6-d60b6339e122"), "Versace" },
                    { new Guid("d51213ea-c69b-428e-8a44-7c049edccb99"), "Swiss Military Hanowa" },
                    { new Guid("d5253452-2fca-4023-a8c3-0561b5001637"), "NIKA" },
                    { new Guid("d6749a6d-0e00-4505-ac46-3ba8816bb325"), "Candino" },
                    { new Guid("d7f3c100-d752-4301-82ec-66289b2d2a38"), "Aviator" },
                    { new Guid("d839ac61-c47b-4e9d-bdd3-56c442f02582"), "Calvin Klein" },
                    { new Guid("d880d305-de96-40d4-ad08-eb3215e00baf"), "VMF" },
                    { new Guid("de631b24-fb3d-4c6b-978f-d1131ffdc812"), "HEAD" },
                    { new Guid("de89be33-be43-4dc7-b3df-7cec53c1fe39"), "Wenger" },
                    { new Guid("dfaa8612-d277-4b50-ab1a-a15eef53598f"), "Korloff" },
                    { new Guid("dfedf668-d442-47ec-88c9-6c1bb89fd99a"), "Mondaine" },
                    { new Guid("e1989740-892a-47a5-9013-a0cf53ec0b1d"), "Corum" },
                    { new Guid("e1a9b8d7-df7e-4144-8c13-0abf3221189b"), "Carl von Zeyten" },
                    { new Guid("e3609c9d-602b-428e-b88a-2e43b4395e19"), "Certina" },
                    { new Guid("e68f9688-bcea-4972-b782-1e70c600616b"), "Mazzucato" },
                    { new Guid("eaa22f37-9fc2-4845-8ed5-962397e3924d"), "Cuervo y Sobrinos" },
                    { new Guid("eab1d80c-0e91-46ed-8a59-0634e9ea2c8c"), "Graham" },
                    { new Guid("eb7c4ba7-331f-4eda-989e-53790afd07b3"), "Thomas Sabo" },
                    { new Guid("ec108c01-35ce-473a-adbd-9880309e88f6"), "Locman" },
                    { new Guid("effdadcf-7853-431b-a95c-c95de85a7044"), "Спецназ" },
                    { new Guid("f79cb804-9132-4d98-bf18-5ba4690be5cf"), "Guess" },
                    { new Guid("f83bf5eb-c547-4698-b342-b67ebe6b0557"), "Citizen" },
                    { new Guid("f8436e86-e6d1-47c9-9801-ccbbc45eb735"), "Guess Originals" },
                    { new Guid("f9159071-9201-435e-b8b8-fee8f777448e"), "Just Cavalli" },
                    { new Guid("fb390df2-dc06-48e7-8709-701354fdf453"), "Grand Seiko" },
                    { new Guid("fd76b7f8-9e31-4a1f-a484-4f8d7ea7bea1"), "Bauhaus" }
                });

            migrationBuilder.InsertData(
                table: "CaseColors",
                columns: new[] { "Id", "Name" },
                values: new object[,]
                {
                    { new Guid("0764bfe1-69ae-4de4-97c4-e0e5a6dbd43f"), "Голубой" },
                    { new Guid("12a87818-f013-4d43-8742-f9d142319c31"), "Прозрачный" },
                    { new Guid("235d3f02-12fe-4a22-bc39-61096039dbaf"), "Синий" },
                    { new Guid("48ad5b70-8823-4cb9-8381-4adb76ee2286"), "Серый" },
                    { new Guid("4f736d86-1047-477c-9838-35533faa2040"), "Коричневый" },
                    { new Guid("6e53f786-f928-40ab-a002-318f1fc47cf6"), "Позолоченный" },
                    { new Guid("6f2065f9-8ad8-4dac-815c-c8d2219c433b"), "Фиолетовый" },
                    { new Guid("7c761c7e-ea6c-4a5b-9558-4d8b4eb8532e"), "Розовый" },
                    { new Guid("9ab3f512-a307-424b-be61-3cb8f3a6d3f4"), "Оранжевый" },
                    { new Guid("9d1254b9-78eb-478c-95c4-a6423d23fda7"), "Разноцветные" },
                    { new Guid("a20b9c1d-f82a-44af-b1a4-3f67bcea3d77"), "Зеленый" },
                    { new Guid("ada979b6-ee38-438b-8bb5-f576ab91f902"), "Двухцветный" },
                    { new Guid("afd5e969-3f53-4785-b63a-227cec2efd9f"), "Белый" },
                    { new Guid("c8373f91-c09a-4a08-af22-7f782c661c83"), "Красный" },
                    { new Guid("dfa35423-626f-4985-b458-c4ffe9db07c7"), "Бежевый" },
                    { new Guid("f057550e-b5f0-4a58-b617-432f12567a6f"), "Черный" },
                    { new Guid("f482244b-f9bd-4a90-9081-7e5384b10529"), "Желтый" }
                });

            migrationBuilder.InsertData(
                table: "CaseForms",
                columns: new[] { "Id", "Name" },
                values: new object[,]
                {
                    { new Guid("4ab0dc67-96b5-417e-ac14-3adef5f49b51"), "Треугольник" },
                    { new Guid("6b98937b-f022-4107-8544-e171152d133c"), "Квадрат" },
                    { new Guid("867dbda3-8cf3-4bdc-811a-74f177d520d7"), "Круг" },
                    { new Guid("a40d52f0-77e4-45ec-a394-59e1cf17d79b"), "Прямоугольник" },
                    { new Guid("bd3e5801-a54f-46e3-93f0-c6b7334e727b"), "Овал" },
                    { new Guid("bf64ed74-f3f1-438e-b061-de8d55118b58"), "Необычный" },
                    { new Guid("d727ee20-e277-4ca0-8ef7-6877090e6b30"), "Бочка" }
                });

            migrationBuilder.InsertData(
                table: "CaseMaterials",
                columns: new[] { "Id", "Name" },
                values: new object[,]
                {
                    { new Guid("014b2a1d-d895-40a7-9d9a-f41c42df0c9d"), "Пластик" },
                    { new Guid("0d8791b3-ce74-4feb-bdc1-d38c5740a747"), "Белое золото" },
                    { new Guid("0f94d265-2c4d-4c2c-8826-9a30f268e974"), "Каучук" },
                    { new Guid("103c6169-66e9-436f-86dc-040a72950f30"), "Силикон" },
                    { new Guid("124e456f-d10c-4bc1-b659-b1e8d6271d46"), "Красное золото" },
                    { new Guid("176f20ef-d864-41f7-9df1-878c8828caf0"), "Розовое золото" },
                    { new Guid("1a95a3f9-8c1b-4aff-999c-0cb35f23ba1c"), "Серебро" },
                    { new Guid("4a74034c-ea07-4a16-8a01-05721885f112"), "Бронза" },
                    { new Guid("50291767-14ce-45b2-9fe4-b4498929e285"), "Металлический" },
                    { new Guid("5e45cf74-2cf3-4704-86f6-33fbec2c0af9"), "Сталь" },
                    { new Guid("60479906-756e-4eba-99d4-af6cb25b4d2f"), "Желтое золото" },
                    { new Guid("6f8be7a0-cf14-4952-8ea4-f829c78518e1"), "Алюминий" },
                    { new Guid("77b4c398-fdd5-40cf-b59a-c310cd5c4051"), "Керамический" },
                    { new Guid("7c34d765-1914-41b9-8cbb-376e68ab9a3e"), "Титан" },
                    { new Guid("7d14c639-1f93-4089-95b4-d3f04e931ee9"), "Резина" },
                    { new Guid("aac33f0a-c7e2-43a2-94a6-ab1e4a0b0041"), "Золото" },
                    { new Guid("ef2a16ac-6ed4-4f75-adc1-957e9055a5ed"), "Карбон" }
                });

            migrationBuilder.InsertData(
                table: "CaseSizes",
                columns: new[] { "Id", "Name" },
                values: new object[,]
                {
                    { new Guid("02c8dc3f-3560-4216-838e-bdd606a9a25f"), "Стандартные" },
                    { new Guid("34c1a17d-61af-4d53-b100-ff757d7c4f1d"), "Большие" },
                    { new Guid("dc730cfe-6460-496b-ad58-53796ceb1ef0"), "Маленькие" },
                    { new Guid("de054b7e-d0e7-4d23-90e0-847b0aaa149f"), "Тонкие" }
                });

            migrationBuilder.InsertData(
                table: "ClockFaces",
                columns: new[] { "Id", "Name" },
                values: new object[,]
                {
                    { new Guid("49eda4f3-a961-460b-976b-30ebdd931641"), "Стрелочный" },
                    { new Guid("8d3fb79f-5515-42ae-bb87-df8622cd5036"), "Цифровой" },
                    { new Guid("9be7b985-5942-4e12-85f1-14460ab4e173"), "Комбинированный" }
                });

            migrationBuilder.InsertData(
                table: "Countries",
                columns: new[] { "Id", "Name" },
                values: new object[,]
                {
                    { new Guid("0d318fcc-0408-46c5-82d9-ad3e28c384f6"), "Австрия" },
                    { new Guid("1863e33d-bded-402b-8251-8dae2daf75e4"), "Италия" },
                    { new Guid("18c9e79f-7f62-4869-9b35-ae69ad746311"), "Россия" },
                    { new Guid("2d32f8d0-4492-42a0-84ed-6ab167c86a5f"), "Великобритания" },
                    { new Guid("2fee547d-5070-4c81-8a4d-b8d4d5106cfa"), "Китай" },
                    { new Guid("31c16712-7a39-4469-aaeb-5a76e1fd4a12"), "Испания" },
                    { new Guid("3945cbd8-c7f6-478d-874d-04e7955c9e63"), "Япония" },
                    { new Guid("4045e52f-f082-4aa4-b2b1-f70f9593b148"), "Дания" },
                    { new Guid("64c0b3a3-844e-4cc6-85c6-5cd141e70498"), "Финляндия" },
                    { new Guid("67fb6a12-2c8c-4c5f-af6b-d16ebdd5de78"), "Турция" },
                    { new Guid("72783be3-5e78-4a3c-95e2-2bc0d8fb3548"), "Франция" },
                    { new Guid("7b9eedfc-b5ea-403d-9a73-003d3c681546"), "Бельгия" },
                    { new Guid("8c581dff-c02a-4e7e-8e3f-035326ca287e"), "Южная Корея" },
                    { new Guid("9866111b-19cb-4122-8bf0-7d25ad74ddb0"), "Швейцария" },
                    { new Guid("df83dc01-d929-4d74-8bf8-b5fdeb40bc41"), "Швеция" },
                    { new Guid("e1b324d5-e946-496e-9187-84f11bf83a58"), "США" },
                    { new Guid("ee47760f-f229-4c87-9f54-75eda2d24aa2"), "Гонконг" },
                    { new Guid("f2e4e903-87d8-4e8b-8414-e8b480f36920"), "Германия" }
                });

            migrationBuilder.InsertData(
                table: "Decorations",
                columns: new[] { "Id", "Name" },
                values: new object[,]
                {
                    { new Guid("00f9e8aa-5513-44b3-94fe-77f9edbe6421"), "Сапфиры" },
                    { new Guid("0b83296a-d30d-4d0e-8cdf-f5d80cd9283a"), "Вставки керамические" },
                    { new Guid("0ef3976e-5dd2-4256-a81d-95b0238c65ad"), "Кристаллы Swarovski" },
                    { new Guid("10aaf1f1-ee7f-4728-8823-835c2e3117c4"), "Эмаль" },
                    { new Guid("144f0222-c75f-4f31-afaa-a30498eabcba"), "Аметисты" },
                    { new Guid("2487911a-3586-447a-93af-9753dda23378"), "Цирконы" },
                    { new Guid("2faf2950-1f39-45ac-9b40-f3cb66a36d0f"), "Жемчуг" },
                    { new Guid("4222c063-ddc4-47bd-8854-a82d1e4993f5"), "Фианиты" },
                    { new Guid("71c0f11a-f01c-49cb-aa41-5d9d4369a2e9"), "Рубины" },
                    { new Guid("803d8faf-a409-4d38-bdf7-b676bb67c7aa"), "Вставки из пластика" },
                    { new Guid("86cce35c-7d8b-4369-be97-5da5a87bdc21"), "Топазы" },
                    { new Guid("c8c6a2de-14ef-4e31-b878-919adf3833ff"), "Хрусталь" },
                    { new Guid("e0a8c827-36c8-4295-a6e2-f105058b55fc"), "Янтарь" },
                    { new Guid("f3b81bbe-8567-4294-a6ee-96fad70fe124"), "Бриллианты" },
                    { new Guid("f9dcb882-5b00-455b-b66c-625fae6255b3"), "Вставки из золота" }
                });

            migrationBuilder.InsertData(
                table: "GlassTypes",
                columns: new[] { "Id", "Name" },
                values: new object[,]
                {
                    { new Guid("187f822b-6d17-4dd2-aedb-4e84c9d10cfb"), "Органическое" },
                    { new Guid("207340a6-0c87-4223-9c40-c806fd8bdf26"), "Минеральное" },
                    { new Guid("6126d885-dc07-4780-8c25-8b09f4fdb524"), "Сапфировое" }
                });

            migrationBuilder.InsertData(
                table: "NumberTypes",
                columns: new[] { "Id", "Name" },
                values: new object[,]
                {
                    { new Guid("18a2e431-a717-452c-b98c-9f5a9aa8367e"), "Римские" },
                    { new Guid("20a61d40-651c-4dfb-9a96-6b068e08d7fb"), "Штрихи" },
                    { new Guid("8a4ef251-333e-46de-8efa-071afd778092"), "Точки" },
                    { new Guid("a75420dd-91f8-44db-8f53-cd340a270588"), "Без меток" },
                    { new Guid("d54da21e-eafa-4140-81b0-e091acc0a10a"), "Арабские" }
                });

            migrationBuilder.InsertData(
                table: "Styles",
                columns: new[] { "Id", "Name" },
                values: new object[,]
                {
                    { new Guid("104ff71d-da7f-4de5-ad80-05f3fe01dc3f"), "Милитари" },
                    { new Guid("2e6a83aa-4fab-4e3f-848c-72e0b86df844"), "Военные" },
                    { new Guid("365239da-e64f-46b9-a275-f0df928062bc"), "Дизайнерские" },
                    { new Guid("449d08d3-1afd-4ac8-b2cf-ea0a2bfba404"), "Пилотские" },
                    { new Guid("84a98ad6-195a-4791-8d15-6a425acdcfb1"), "Спортивные" },
                    { new Guid("9f554d9e-106e-4311-b6b0-f5782515e042"), "На каждый день" },
                    { new Guid("e2da6523-8609-4013-853e-f57a263dc04c"), "Под костюм" }
                });

            migrationBuilder.InsertData(
                table: "WaterResistants",
                columns: new[] { "Id", "Name" },
                values: new object[,]
                {
                    { new Guid("4b37d4e2-c212-4ff7-ba3c-c6f2048c2179"), "От 30WR" },
                    { new Guid("5970c7c3-8971-41dc-98a3-a527831307c2"), "От 200WR" },
                    { new Guid("9bb13ddc-76ce-447a-9754-4ab9da20a6cf"), "От 10WR" },
                    { new Guid("c749bca2-b4e6-4453-99bf-c69aa2478200"), "От 100WR" },
                    { new Guid("da18a593-e43d-43ce-bd94-348c364f9425"), "От 50WR" },
                    { new Guid("fad395ea-8b22-4077-b00b-f9a938f8d549"), "От 300WR" }
                });

            migrationBuilder.CreateIndex(
                name: "IX_AdditionallWatch_WatchesId",
                table: "AdditionallWatch",
                column: "WatchesId");

            migrationBuilder.CreateIndex(
                name: "IX_AspNetRoleClaims_RoleId",
                table: "AspNetRoleClaims",
                column: "RoleId");

            migrationBuilder.CreateIndex(
                name: "RoleNameIndex",
                table: "AspNetRoles",
                column: "NormalizedName",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_AspNetUserClaims_UserId",
                table: "AspNetUserClaims",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_AspNetUserLogins_UserId",
                table: "AspNetUserLogins",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_AspNetUserRoles_RoleId",
                table: "AspNetUserRoles",
                column: "RoleId");

            migrationBuilder.CreateIndex(
                name: "EmailIndex",
                table: "AspNetUsers",
                column: "NormalizedEmail");

            migrationBuilder.CreateIndex(
                name: "UserNameIndex",
                table: "AspNetUsers",
                column: "NormalizedUserName",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_DecorationWatch_WatchesId",
                table: "DecorationWatch",
                column: "WatchesId");

            migrationBuilder.CreateIndex(
                name: "IX_Watches_BacklightId",
                table: "Watches",
                column: "BacklightId");

            migrationBuilder.CreateIndex(
                name: "IX_Watches_BraceletColorId",
                table: "Watches",
                column: "BraceletColorId");

            migrationBuilder.CreateIndex(
                name: "IX_Watches_BraceletId",
                table: "Watches",
                column: "BraceletId");

            migrationBuilder.CreateIndex(
                name: "IX_Watches_BrandId",
                table: "Watches",
                column: "BrandId");

            migrationBuilder.CreateIndex(
                name: "IX_Watches_CaseColorId",
                table: "Watches",
                column: "CaseColorId");

            migrationBuilder.CreateIndex(
                name: "IX_Watches_CaseFormId",
                table: "Watches",
                column: "CaseFormId");

            migrationBuilder.CreateIndex(
                name: "IX_Watches_CaseMaterialId",
                table: "Watches",
                column: "CaseMaterialId");

            migrationBuilder.CreateIndex(
                name: "IX_Watches_CaseSizeId",
                table: "Watches",
                column: "CaseSizeId");

            migrationBuilder.CreateIndex(
                name: "IX_Watches_ClockFaceId",
                table: "Watches",
                column: "ClockFaceId");

            migrationBuilder.CreateIndex(
                name: "IX_Watches_CountryId",
                table: "Watches",
                column: "CountryId");

            migrationBuilder.CreateIndex(
                name: "IX_Watches_GlassTypeId",
                table: "Watches",
                column: "GlassTypeId");

            migrationBuilder.CreateIndex(
                name: "IX_Watches_NumberTypeId",
                table: "Watches",
                column: "NumberTypeId");

            migrationBuilder.CreateIndex(
                name: "IX_Watches_StyleId",
                table: "Watches",
                column: "StyleId");

            migrationBuilder.CreateIndex(
                name: "IX_Watches_WaterResistantId",
                table: "Watches",
                column: "WaterResistantId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "AdditionallWatch");

            migrationBuilder.DropTable(
                name: "AspNetRoleClaims");

            migrationBuilder.DropTable(
                name: "AspNetUserClaims");

            migrationBuilder.DropTable(
                name: "AspNetUserLogins");

            migrationBuilder.DropTable(
                name: "AspNetUserRoles");

            migrationBuilder.DropTable(
                name: "AspNetUserTokens");

            migrationBuilder.DropTable(
                name: "DecorationWatch");

            migrationBuilder.DropTable(
                name: "Additionalls");

            migrationBuilder.DropTable(
                name: "AspNetRoles");

            migrationBuilder.DropTable(
                name: "AspNetUsers");

            migrationBuilder.DropTable(
                name: "Decorations");

            migrationBuilder.DropTable(
                name: "Watches");

            migrationBuilder.DropTable(
                name: "Backlights");

            migrationBuilder.DropTable(
                name: "BraceletColors");

            migrationBuilder.DropTable(
                name: "Bracelets");

            migrationBuilder.DropTable(
                name: "Brands");

            migrationBuilder.DropTable(
                name: "CaseColors");

            migrationBuilder.DropTable(
                name: "CaseForms");

            migrationBuilder.DropTable(
                name: "CaseMaterials");

            migrationBuilder.DropTable(
                name: "CaseSizes");

            migrationBuilder.DropTable(
                name: "ClockFaces");

            migrationBuilder.DropTable(
                name: "Countries");

            migrationBuilder.DropTable(
                name: "GlassTypes");

            migrationBuilder.DropTable(
                name: "NumberTypes");

            migrationBuilder.DropTable(
                name: "Styles");

            migrationBuilder.DropTable(
                name: "WaterResistants");
        }
    }
}
