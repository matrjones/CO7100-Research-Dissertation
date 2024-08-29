using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ReptileAPI.Migrations
{
    /// <inheritdoc />
    public partial class AddedParametersToVivarium : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<Guid>(
                name: "ParameterId",
                table: "Vivaria",
                type: "uniqueidentifier",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.CreateTable(
                name: "Parameters",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    LightOn = table.Column<DateTime>(type: "datetime2", nullable: false),
                    LightOff = table.Column<DateTime>(type: "datetime2", nullable: false),
                    DayTemp = table.Column<int>(type: "int", nullable: false),
                    NightTemp = table.Column<int>(type: "int", nullable: false),
                    CreatedDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedDate = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Parameters", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Vivaria_ParameterId",
                table: "Vivaria",
                column: "ParameterId");

            migrationBuilder.AddForeignKey(
                name: "FK_Vivaria_Parameters_ParameterId",
                table: "Vivaria",
                column: "ParameterId",
                principalTable: "Parameters",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Vivaria_Parameters_ParameterId",
                table: "Vivaria");

            migrationBuilder.DropTable(
                name: "Parameters");

            migrationBuilder.DropIndex(
                name: "IX_Vivaria_ParameterId",
                table: "Vivaria");

            migrationBuilder.DropColumn(
                name: "ParameterId",
                table: "Vivaria");
        }
    }
}
