﻿Imports DevExpress.Web
Imports System.Reflection.MethodBase
Imports System.Drawing
Imports System.IO
Imports DevExpress.Web.Data
Public Class el_edit_soal
    Inherits System.Web.UI.Page
    Dim dr_user As DataRow
    Dim str As String
    Dim strg As String
    Dim salah As er_custom
    Dim waktu_query As New Stopwatch
    Dim waktu_page As New Stopwatch
    Dim dt, dt_level, dt_pre, dt_materi, dt_soal As New DataTable
    Dim str_menu As String = ",2,"
    Dim dr As DataRow
    Dim idrec As Int64
    Dim cb As GridViewDataComboBoxColumn
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub el_edit_soal_LoadComplete(sender As Object, e As EventArgs) Handles Me.LoadComplete

    End Sub

    Private Sub el_edit_soal_PreInit(sender As Object, e As EventArgs) Handles Me.PreInit

        Me.waktu_page.Start()
    End Sub

    Private Sub el_edit_soal_Init(sender As Object, e As EventArgs) Handles Me.Init
        Try
            idrec = Request.QueryString("idrec")
        Catch ex As Exception
            Response.Redirect("home.aspx")
        End Try
        dr_user = Session("dr_user")
        Me.isi_data()
    End Sub
    Private Sub Jika_error(er_str As String, er_hasil As String, er_menu As String, nopesan As Integer)
        salah.er_str = er_str
        salah.er_menu = er_menu
        salah.er_waktu = Mod_Utama.str_waktu(Me.waktu_query, Me.waktu_page)
        Session("error") = salah

        Select Case nopesan
            Case 1
                Mod_Utama.tampil_error(Me, "Terjadinya kesalahan pada Query, harap kirim laporan ke MIS via email")
            Case Else
                Mod_Utama.tampil_error(Me, "Terjadinya kesalahan pada Proses, harap kirim laporan ke MIS via email")
        End Select
    End Sub
    Private Sub isi_data()
        str = "select * from el_tbl_soal where id_soal = '" & Me.idrec & "' order by id_soal DESC"
        Me.salah = Mod_Utama.isi_data(dt, str, "id_soal", waktu_query)
        If salah.er_hasil <> "" Then
            Me.Jika_error(str, salah.er_str, Me.Page.ToString & " // " & GetCurrentMethod.Name, 1)
            Exit Sub
        End If

        For Each dtr As DataRow In dt.Rows
            Me.txid.Value = dtr("id_soal")
            Me.txtsoal.Value = dtr("soal")
            Me.txtjawaban.Value = dtr("jawaban")
            Me.txskor.Value = dtr("skor")
            If dtr("jenis_soal") = "pg" Then
                Me.cb_jenis.SelectedIndex = 0
                Me.cb_jenis.Value = dtr("jenis_soal")
            Else
                Me.cb_jenis.SelectedIndex = 1
                Me.cb_jenis.Value = dtr("jenis_soal")
            End If
            If dtr("tipe_soal") = "gambar" Then
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "HideElement", "$('#inputlink').hide();", True)
                Me.cb_tipe.Value = "gambar"
                Me.cb_tipe.SelectedIndex = "1"
                strg = "<img  id='gambar' runat='server' style='width: 50%; height: auto;'   src='gambar/" & dtr("file_gambar") & "' />"
                Me.gambar.InnerHtml = strg


            ElseIf dtr("tipe_soal") = "link" Then
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "HideElement", "$('#inputfile').hide();", True)
                Me.cb_tipe.Value = "link"
                Me.cb_tipe.SelectedIndex = "2"
                Me.txlink.Value = dtr("file_gambar")


            ElseIf dtr("tipe_soal") = "text" Then
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "HideInputLink", "$('#inputlink').hide();", True)
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "HideInputFile", "$('#inputfile').hide();", True)
                Me.cb_tipe.Value = "text"
                Me.cb_tipe.SelectedIndex = "0"
            End If
        Next
    End Sub
    Protected Sub btnedit_ServerClick(sender As Object, e As EventArgs)
        If Me.cb_tipe.Value = "link" Or Me.cb_tipe.Value = "text" Then
            If Me.txgambar.Value <> "" Then
                Try
                    File.Delete(Server.MapPath("~\gambar\" & Me.txgambar.Value))
                Catch ex As Exception
                    Mod_Utama.tampil_error(Me, "Terjadi Kesalahan Query, Silahkan Hubungi Staff IT")
                End Try
            End If
            Me.updatelink()
            Response.Redirect(Request.RawUrl)

        Else
            If Me.txfile.Value = "" Then
                Me.updatefiles()

            Else
                Dim filepath As String = txfile.PostedFile.FileName
                Dim filename As String = Path.GetFileName(filepath)
                Dim ext As String = Path.GetExtension(filename)

                Dim title As String = "image" & Me.idrec & "_" & Format(Now, "yyyyMMddHHmmss")

                Dim filepost As HttpPostedFile = txfile.PostedFile
                Dim filekb As Integer = filepost.ContentLength

                Dim filecurr As HttpPostedFile
                If ext.ToLower <> ".jpg" And ext.ToLower <> ".png" Then
                    filecurr = txfile.PostedFile
                Else
                    If filekb > 800000 Then
                        resize_img(txfile.PostedFile, ext, title)
                        Return
                    Else
                        filecurr = txfile.PostedFile
                    End If
                End If

                Try
                    txfile.PostedFile.SaveAs(Server.MapPath("~\gambar\" & title & ext))
                Catch ex As Exception
                    Mod_Utama.tampil_error(Me, "Simpan Standart Gambar User Tidak Berhasil")
                    Return
                End Try

                If Me.updatefile(title, ext) = False Then
                    Mod_Utama.tampil_error(Me, "Simpan Standart Gambar User Tidak Berhasil")
                    Exit Sub
                End If

                Mod_Utama.tampil_sukses(Me, "Simpan Gambar User Terbaru Telah Berhasil")
                Me.isi_data()
                Response.Redirect(Request.RawUrl)

            End If
        End If
    End Sub
    Private Sub updatelink()
        str = "UPDATE el_tbl_soal set "
        str = str & "soal = '" & Me.txtsoal.Value & "', "
        str = str & "jawaban = '" & Me.txtjawaban.Value & "', "
        str = str & "file_gambar = '" & Me.txlink.Value & "', "
        str = str & "skor = '" & Me.txskor.Value & "', "
        str = str & "tipe_soal = '" & Me.cb_tipe.Value & "', "
        str = str & "jenis_soal = '" & Me.cb_jenis.Value & "', "
        str = str & "c_date = getdate(), "
        str = str & "c_user = '" & dr_user("nama") & "' "
        str = str & "where id_soal = " & Me.txid.Value
        salah.er_hasil = Mod_Utama.exec_sql(str, dr_user, "AUTH USER")
        If salah.er_hasil = "" Then
            Mod_Utama.tampil_sukses(Me, "Update Berhasil")
        Else
            Mod_Utama.tampil_error(Me, "Terjadinya kesalahan pada Proses, harap kirim laporan ke MIS via email")
        End If
    End Sub

    Private Function updatefile(nmfile As String, extion As String) As Boolean
        str = "UPDATE el_tbl_soal set "
        str = str & "soal = '" & Me.txtsoal.Value & "', "
        str = str & "jawaban = '" & Me.txtjawaban.Value & "', "
        str = str & "file_gambar = '" & nmfile & extion & "', "
        str = str & "nama_file = '" & Me.txfile.Value & "', "
        str = str & "skor = '" & Me.txskor.Value & "', "
        str = str & "tipe_soal = '" & Me.cb_tipe.Value & "', "
        str = str & "jenis_soal = '" & Me.cb_jenis.Value & "', "
        str = str & "c_date = getdate(), "
        str = str & "c_user = '" & dr_user("nama") & "' "
        str = str & "where id_soal = " & Me.txid.Value
        salah.er_hasil = Mod_Utama.exec_sql(str, dr_user, "AUTH USER")
        If salah.er_hasil = "" Then
            Mod_Utama.tampil_sukses(Me, "Update Berhasil")
        Else
            Mod_Utama.tampil_error(Me, "Terjadinya kesalahan pada Proses, harap kirim laporan ke MIS via email")
        End If

        Return True
    End Function

    Private Function updatefiles() As Boolean
        str = "UPDATE el_tbl_soal set "
        str = str & "soal = '" & Me.txtsoal.Value & "', "
        str = str & "jawaban = '" & Me.txtjawaban.Value & "', "
        str = str & "skor = '" & Me.txskor.Value & "', "
        str = str & "tipe_soal = '" & Me.cb_tipe.Value & "', "
        str = str & "jenis_soal = '" & Me.cb_jenis.Value & "', "
        str = str & "c_date = getdate(), "
        str = str & "c_user = '" & dr_user("nama") & "' "
        str = str & "where id_soal = " & Me.txid.Value
        salah.er_hasil = Mod_Utama.exec_sql(str, dr_user, "AUTH USER")
        If salah.er_hasil = "" Then
            Mod_Utama.tampil_sukses(Me, "Update Berhasil")
        Else
            Mod_Utama.tampil_error(Me, "Terjadinya kesalahan pada Proses, harap kirim laporan ke MIS via email")
        End If

        Return True
    End Function
    Private Sub resize_img(filenm As HttpPostedFile, extion As String, title As String)
        Dim stream As Stream = filenm.InputStream
        Dim oriimg As Bitmap = New Bitmap(stream)

        Dim newheight As Integer = CInt(oriimg.Height * (CSng(600) / CSng(oriimg.Width)))
        Dim newimg As Bitmap = New Bitmap(600, newheight)
        Dim graf As Graphics = Graphics.FromImage(newimg)
        graf.InterpolationMode = Drawing2D.InterpolationMode.HighQualityBicubic
        graf.DrawImage(oriimg, 0, 0, 600, newheight)

        Try
            newimg.Save(Server.MapPath("~\gambar\" & title & extion))
        Catch ex As Exception
            Mod_Utama.tampil_error(Me, "Simpan BIG Gambar User Tidak Berhasil")
            Exit Sub
        End Try


        If Me.updatefile(title, extion) = False Then
            Mod_Utama.tampil_error(Me, "Simpan BIG Gambar User Tidak Berhasil")
        End If

        Mod_Utama.tampil_sukses(Me, "Simpan BIG Gambar User Terbaru Berhasil")
        Me.isi_data()

    End Sub
End Class