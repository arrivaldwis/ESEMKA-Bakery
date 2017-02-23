using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using TO2_ESEMKA_BAKERY.Class;

namespace TO2_ESEMKA_BAKERY
{
    public partial class baseForm : Form
    {
        public selectiontestwsc2017Entities data = new selectiontestwsc2017Entities();
        public Helpers helper = new Helpers();

        public baseForm()
        {
            InitializeComponent();
        }
    }
}
