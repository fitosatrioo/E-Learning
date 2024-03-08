﻿<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site1.Master" CodeBehind="el_nilai.aspx.vb" Inherits="e_learning.el_nilai" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

  <style>
            .container {
              width: 80%;
              margin: 0 auto;
              background-color: #f2f2f2;
              padding: 20px;
            }
        
            .nilai1{
          font-size: 20px;
          color:black;
             }
        
            .card-header,
            .card-body,
            .table-responsive {
              background-color: #c3f0ef;
            }
        
            .card-header,
            .card-body {
              margin-bottom: 20px;
            }
        
            .navbar {
              background-color: #47bb94;
              color: white;
            }
        
            .navbar .nav-link {
              color: cyan;
              margin-left: 100px;
            }
        
            .circle {
              margin: 0 10px;
              background-color: #9661ad;
              width: 120px;
              height: 120px;
              border-radius: 50%;
            }
        
            .circle2 {
              background-color: white;
              border-radius: 50%;
              width: 70px;
              height: 70px;
              margin: 25px;
              display: flex;
              align-items: center;
              justify-content: center;
            }
        
            .circle2 p {
              font-size: 25px;
            }
        
            .navbar .nav-link:last-child {
              margin-left: 0;
            }
        
            .table-responsive table {
              display: none;
            }
        
            @media only screen and (max-width: 768px) {
              .container {
                width: 100%;
              }
        
             
        
              .navbar .nav-link {
                margin-left: 0;
                margin-bottom: 10px;
              }
        
              .circle {
                margin: 10px 0;
              }
        
              .table-responsive table {
                display: table;
              }
        
             .nilai1{
        font-size: 25px;
        display: block;
             }
            }
          </style>

          <div class="card text-center">
            <div style="background-color: #47bb94" class="card-header">
                <nav style="background-color: #47bb94"  class="navbar navbar-expand-lg ">
              <a style="color: white" class="navbar-brand" href="#"><label runat="server" id="lbljudul"></label></a>
              <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
              </button>
                     
              <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                  <li class="nav-item">
                      
                    <a style="color: cyan; margin-left:200px" class="nav-link" href="#">Date</a>
            </label><label style="margin-left: 200px" runat="server" id="lbldate"></label></a>
                  </li>
                  </li>
                  <li class="nav-item">
                    <a style="color: cyan; margin-left:100px" class="nav-link" href="#">Name</a>
                      </label><label style="margin-left: 100px" runat="server" id="lblname"></label></a>
                  </li>
                  <li class="nav-item">
                    <a style="color: cyan; margin-left:100px" class="nav-link" href="#">ID Quiz</a>
                    </label><label style="margin-left: 100px" runat="server" id="lblmquiz"></label></a>
                  </li>
            
                </ul>
              </div>
            </nav>
          
            </div>
            <div class="card-body">

            <div style="background-color: #c3f0ef" class="card">

              <table class="mt-4">
                <tr>
                  <th style="padding-left: 180px;">Nilai Pre Test</th>
                  <th style="padding-left: 35px;">Nilai Post Test</th>
                  <th style="padding-right: 155px;">Persentase Kenaikan</th>
                </tr>
               
              </table>
              
             
                <div class="d-flex justify-content-center mt-2">
                <div style="margin-right: 120px" class="circle">
                  <div class="circle2">
                      
                    <asp:Label style="color: red; font-size: 25px" Text="" ID="skor" runat="server" />
                  </div>
                </div>
          
                     <div class="circle ">
                  <div  class="circle2">
                      
                    <asp:Label style="color: lawngreen; font-size: 25px" Text="" ID="pro" runat="server" />
          
                  </div>
                </div>
          
                     <div style="margin-left: 120px" class="circle ">
                  <div  class="circle2">
                    <asp:Label style="color: #9661ad; font-size: 25px" Text="" ID="persen" runat="server" />
                     
                  </div>
                </div>
          
          
          
                    </div>
          
                    <table class="mt-2">
                      <tr>
                        <th style="padding-left: 180px;"">  <a onclick="tampilkanpre()" style="color: #9661ad; " class="nav-link" href="#">Lihat Detail</a></th>
                        <th style="padding-right: 300px;">  <a onclick="tampilkanpost()" style="color: #9661ad;" class="nav-link" href="#">Lihat Detail</a></th>
                        <th style="padding-right: 80px;"></th>
                      </tr>
                     
                    </table>
              
                 
            <div id="lnksertif" runat="server">
                 
          </div>
            
            </div>
            </div>
            </div>
                       
            
                        
                           
                       
            <div class="table-responsive">
              <table id="pretest" style="display: none;" class="table table-bordered table-hover mt-3">
                <thead class="thead-white">
                  <tr>
                    <th>Skor</th>
                    <th>Pre Test</th>
                    <th>Answer</th>
                     <th>Keterangan</th>
                    
                  </tr>
                </thead>
                <tbody>
                     <asp:Repeater ID="Repeater1" runat="server">
                                                 <ItemTemplate>
                  <tr>
                   
                    <td> <asp:Label runat="server" Text='<%#Eval("skor") %>'></asp:Label></td>
                    <td> <asp:Label runat="server" Text='<%#Eval("soal") %>'></asp:Label></td>
                    <td> <asp:Label runat="server" Text='<%#Eval("jawaban_user") %>'></asp:Label></td>
                    <td>  <%# If(DataBinder.Eval(Container.DataItem, "app_sta") = "1", "<span style=""color: green; font-weight: 600;"">Correct</span>",
                                                                                    If(DataBinder.Eval(Container.DataItem, "app_sta") = "0", "<span style=""color: red; font-weight: 600;"">Incorrect</span>", "")) %></td>
                  </tr>
                
                     </ItemTemplate>
                  </asp:Repeater>
                </tbody>
              </table>
            </div>
            
            
               <div class="table-responsive">
              <table id="posttest" style="display: none;" class="table table-bordered table-hover mt-3">
                <thead class="thead-white">
                  <tr>
                    <th>Skor</th>
                    <th>Post Test</th>
                    <th>Answer</th>
                     <th>Keterangan</th>
                    
                  </tr>
                </thead>
                <tbody>
                       <asp:Repeater ID="Repeater2" runat="server" >
                         <ItemTemplate>
                  <tr>
                   
                   <td> <asp:Label runat="server" Text='<%#Eval("skor") %>'></asp:Label></td>
                    <td> <asp:Label runat="server" Text='<%#Eval("soal") %>'></asp:Label></td>
                    <td> <asp:Label runat="server" Text='<%#Eval("jawaban_user") %>'></asp:Label></td>
                    <td>
                        <div style='<%# GetItemStyle(Container.DataItem) %>'>

                           <%# If(DataBinder.Eval(Container.DataItem, "app_sta") = "1", "<span style=""color: green; font-weight: 600;"">Correct</span>",
                                                                        If(DataBinder.Eval(Container.DataItem, "app_sta") = "0", "<span style=""color: red; font-weight: 600;"">Incorrect</span>", "")) %>

                        </div> 
                        
                       </td>
                  </tr>
            
                 
                              </ItemTemplate>
                        </asp:Repeater>
                </tbody>
              </table>
            </div>
                          
                             
                         
              <script>
                  function tampilkanpre() {

                      var tabel1Element = document.getElementById('pretest');
                      var tabel2Element = document.getElementById('posttest');

                      // Menampilkan tabel 1 dan menyembunyikan tabel 2
                      tabel1Element.style.display = 'table';
                      tabel2Element.style.display = 'none';

                      // Menetapkan tampilan tabel menjadi 'table' (menghapus style display: none)
                      tabelElement.style.display = 'table';
                  }

                  function tampilkanpost() {
                      var tabel1Element = document.getElementById('pretest');
                      var tabel2Element = document.getElementById('posttest');

                      // Menetapkan tampilan tabel menjadi 'table' (menghapus style display: none)
                      tabel1Element.style.display = 'none';
                      tabel2Element.style.display = 'table';
                  }



            </script>

<script src="js/script-sb.js"></script>
<script>
    applyStyle();
</script>
</asp:Content>