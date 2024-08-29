﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using ReptileAPI.Data;

#nullable disable

namespace ReptileAPI.Migrations
{
    [DbContext(typeof(ApplicationDbContext))]
    [Migration("20240826191446_ChangedDateTimeToTimeOnly")]
    partial class ChangedDateTimeToTimeOnly
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "8.0.3")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder);

            modelBuilder.Entity("ReptileAPI.Models.Environment", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<DateTime>("CreatedDate")
                        .HasColumnType("datetime2");

                    b.Property<bool>("Light")
                        .HasColumnType("bit");

                    b.Property<DateTime>("ModifiedDate")
                        .HasColumnType("datetime2");

                    b.Property<double>("Temperature")
                        .HasColumnType("float");

                    b.HasKey("Id");

                    b.ToTable("Environments", (string)null);
                });

            modelBuilder.Entity("ReptileAPI.Models.Parameter", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<DateTime>("CreatedDate")
                        .HasColumnType("datetime2");

                    b.Property<int>("DayTemp")
                        .HasColumnType("int");

                    b.Property<TimeOnly>("LightOff")
                        .HasColumnType("time");

                    b.Property<TimeOnly>("LightOn")
                        .HasColumnType("time");

                    b.Property<DateTime>("ModifiedDate")
                        .HasColumnType("datetime2");

                    b.Property<int>("NightTemp")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.ToTable("Parameters", (string)null);
                });

            modelBuilder.Entity("ReptileAPI.Models.Vivarium", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<DateTime>("CreatedDate")
                        .HasColumnType("datetime2");

                    b.Property<Guid>("EnvironmentId")
                        .HasColumnType("uniqueidentifier");

                    b.Property<DateTime>("ModifiedDate")
                        .HasColumnType("datetime2");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<Guid>("ParameterId")
                        .HasColumnType("uniqueidentifier");

                    b.HasKey("Id");

                    b.HasIndex("EnvironmentId");

                    b.HasIndex("ParameterId");

                    b.ToTable("Vivaria", (string)null);
                });

            modelBuilder.Entity("ReptileAPI.Models.Vivarium", b =>
                {
                    b.HasOne("ReptileAPI.Models.Environment", "Environment")
                        .WithMany()
                        .HasForeignKey("EnvironmentId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("ReptileAPI.Models.Parameter", "Parameter")
                        .WithMany()
                        .HasForeignKey("ParameterId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Environment");

                    b.Navigation("Parameter");
                });
#pragma warning restore 612, 618
        }
    }
}
