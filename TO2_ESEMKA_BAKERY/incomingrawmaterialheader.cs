//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace TO2_ESEMKA_BAKERY
{
    using System;
    using System.Collections.Generic;
    
    public partial class incomingrawmaterialheader
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public incomingrawmaterialheader()
        {
            this.incomingrawmaterialdetails = new HashSet<incomingrawmaterialdetail>();
            this.rawmaterialintakes = new HashSet<rawmaterialintake>();
        }
    
        public int incomingrawmaterialid { get; set; }
        public System.DateTime incomingdate { get; set; }
        public int employeeid { get; set; }
        public string description { get; set; }
    
        public virtual employee employee { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<incomingrawmaterialdetail> incomingrawmaterialdetails { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<rawmaterialintake> rawmaterialintakes { get; set; }
    }
}
