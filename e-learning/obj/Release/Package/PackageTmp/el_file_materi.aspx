﻿<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site1.Master" CodeBehind="el_file_materi.aspx.vb" Inherits="e_learning.el_file_materi" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div class="container mt-4">
              <center>
                   <h1 style="">Pelajari Materi </h1>
                   
              </center>
   
   
               <asp:Repeater ID="Repeater1" runat="server">
                           <ItemTemplate>
    <div class="card mb-4 mt-3">
      <div class="card-body">
        <h5 class="card-title"><%#Eval("nama_materi") %></h5>
              </ItemTemplate>
                      </asp:Repeater>     
   

                <div class="col-xs-6" id="su56" runat="server">
                   
                </div>
                <div class="col-xs-6" >
                    <div>
                        <div style='max-width: 600px; margin: 0 auto; margin-top: 50px;' class='card text-center'>
                            <div class="card-body">
                                <label runat="server" id="lblbc" style="color: green;" >Telah Dibaca</label>
                                <button type="button" class="btn btn-success" runat="server" id="btn_log" onserverclick="btn_log_ServerClick">Tandai Telah Selesai Baca</button>
                            </div>
                        </div>
                    </div>
                    
                </div>
        
      </div>
    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
  function InsertData() {
    // Lakukan permintaan AJAX ke sisi server untuk memanggil fungsi InsertData
    $.ajax({
      type: "POST",
      url: "el_file_materi.aspx/InsertData", // Ubah "el_file_materi.aspx" sesuai dengan nama halaman Anda
      contentType: "application/json; charset=utf-8",
      dataType: "json",
      success: function(response) {
        // Tangani respons dari sisi server jika diperlukan
      },
      error: function(error) {
        // Tangani kesalahan jika diperlukan
      }
    });
  }
    </script>
</asp:Content>
