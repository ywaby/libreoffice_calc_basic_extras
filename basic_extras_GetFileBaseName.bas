'--------------------------------------------------------------------------------------------------'
' GetFileBaseName                                                                                  '
'--------------------------------------------------------------------------------------------------'
' Returns parsed filename of a given path.                                                         '
'                                                                                                  '
' Parameters:                                                                                      '
'                                                                                                  '
'   ByVal FullPath As String                                                                       '
'     Path to parse. ByVal keyword prevents it from modification because by default arguments are  '
'     passed by reference.                                                                         '
'                                                                                                  '
' Examples:                                                                                        '
'--------------------------------------------------------------------------------------------------'
'                                                                                                  '
'     basename = GetFileBaseName(path)                                                             '
'                                                                                                  '
' Expected values:                                                                                 '
'   path: "/home/user/doc.name.ods"               basename: "doc.name.ods"                         '
'   path: "/home/user/document.ods"               basename: "document.ods"                         '
'   path: "/home/user/.htaccess"                  basename: ".htaccess"                            '
'   path: "user/document.ods"                     basename: "document.ods"                         '
'   path: "C:\Users\Admin\Рабочий стол\.htaccess" basename: ".htaccess"                            '
'--------------------------------------------------------------------------------------------------'
' Feedback & Issues:                                                                               '
'   https://github.com/aa6/libreoffice_calc_basic_extras/issues                                    '
'--------------------------------------------------------------------------------------------------'
Function GetFileBaseName(ByVal FullPath As String) As String

    Dim pos As Long
    Dim pathlen As Long
    Dim pathurl As String
    ' Fetching file base name from FullPath.                                                       '
    ' Converting to URL for Linux/Windows compatibility.                                           '
    '   URL notation does not allow certain special characters to be used. These are either        '
    '   replaced by other characters or encoded. A slash (/) is used as a path separator. For      '
    '   example, a file referred to as C:\My File.sxw on the local host in "Windows notation"      '
    '   becomes file:///C|/My%20File.sxw in URL notation.                                          '
    ' https://help.libreoffice.org/Basic/Basic_Glossary                                            '
    pathurl = ConvertToURL(FullPath)
    ' FullPath could be mistakenly converted to http. For example:                                 '
    ' ConvertToURL("many.dots.in.file.name.ods") will be misinterpreted.                           '
    If Left(pathurl,7) <> "file://" Then 
        pathurl = ConvertToURL("/" + FullPath)
    End If
    pathlen = Len(pathurl)
    For pos = pathlen To 1 Step -1
        If Mid(pathurl, pos, 1) = "/" Then
            GetFileBaseName = ConvertFromURL(Right(pathurl, pathlen - pos))
            Exit For
        End If
    Next pos

End Function