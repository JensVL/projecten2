using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Taijitan_Yoshin_Ryu_vzw.Models.Domain;

namespace Taijitan_Yoshin_Ryu_vzw.Data.Mappers {
    public class GebruikerConfiguration : IEntityTypeConfiguration<Gebruiker> {
        public void Configure(EntityTypeBuilder<Gebruiker> builder) {
            #region Table
            builder.ToTable("Gebruiker");
            #endregion

            #region Primary Key
            builder.HasKey(t => t.Username);
            #endregion
        }
    }
}
