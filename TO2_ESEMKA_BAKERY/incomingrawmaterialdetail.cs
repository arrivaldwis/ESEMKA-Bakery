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
    
    public partial class incomingrawmaterialdetail
    {
        public int incomingrawmaterialid { get; set; }
        public int rawmaterialid { get; set; }
        public int priceper100gram { get; set; }
        public System.DateTime bestbeforedate { get; set; }
        public int weightingram { get; set; }
    
        public virtual incomingrawmaterialheader incomingrawmaterialheader { get; set; }
        public virtual rawmaterial rawmaterial { get; set; }
    }
}
