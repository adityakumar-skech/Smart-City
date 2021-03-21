using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class gurudwara : System.Web.UI.Page
{
    db d = new db();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        d.insertData("insert into tbl_places values(" + d.latestId("tbl_places", "placeid") + ",2,'" + TextBox7.Text + "','" + TextBox8.Text + "','" + TextBox1.Text + "','" + TextBox2.Text + "','" + TextBox3.Text + "','" + TextBox4.Text + "','" + TextBox5.Text + "','" + TextBox6.Text + "')");
    }
}