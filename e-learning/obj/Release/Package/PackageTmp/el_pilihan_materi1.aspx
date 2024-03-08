﻿<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site1.Master" CodeBehind="el_pilihan_materi1.aspx.vb" Inherits="e_learning.el_pilihan_materi1" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
          <div class="container mt-4">
    <h1 style="color:#47bb94">E-Learning <span style="color:darkblue">Agung<span style="color: deepskyblue">logistics</span></span> </h1>
              
    <p>Silakan pilih materi yang ingin Anda pelajari:</p>

 
    <!-- Materi List -->
    <div class="row" runat="server" id="su35">
        <asp:Repeater ID="Repeater1" runat="server" OnItemDataBound="Repeater1_ItemDataBound">
       <ItemTemplate>
      <div  runat="server" id="iyh">
        <div class="card mb-4">
          <div class="card-body text-center table-bordered">
            <h5 class="card-title"><asp:Label runat="server" ID="Label1" Text='<%#Eval("nama_materi") %>'></asp:Label></h5>
            <p class="card-text"><asp:Label runat="server" ID="lbljudul" Text='<%#Eval("keterangan") %>'></asp:Label></p>
              <div id="su25" runat="server">
                <a href="el_file_materi.aspx?idrec=<%#Eval("id_isimt") %>&id_mquiz=<%#Eval("id_mquiz") %>"  class="btn btn-primary" >Baca Materi</a>
              </div>
              
          </div>
        </div>
      </div>
          
         </ItemTemplate>
   </asp:Repeater>

    </div>
        <div class="row" runat="server" id="su57" visible="false">
        
      <div class="col-md-6" runat="server" id="iyh">
        <div class="card mb-4">
          <div class="card-body">
            <h5 class="card-title"><asp:Label runat="server" Text='Kerjakan Pre Test Terlebih Dahulu'></asp:Label></h5>
            
          </div>
        </div>
      </div>

    </div>
  </div>
              </div>
    
</asp:Content>