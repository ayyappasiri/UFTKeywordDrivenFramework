Option Explicit
'*********************************************************
' JAVA KEYWORDS
'*********************************************************
Class JavaKeyword
	
	'*********************************************************
	' Purpose:  Run the action linked to a Java Keyword
	' Inputs:   
	'           strKeyword:       the keyword linked to the function to run
	'           strBrowserID:    the id of the Browser in the ObjectRepository
	'           strPageID:         the id of the Page in the ObjectRepository
	'           strObjectID:       the id of the object in the ObjectRepository
	'           strParam1:        first parameter to pass to the function to run (optional)
	'           strParam2:        second parameter to pass to the function to run (optional)
	'           strParam3:        third parameter to pass to the function to run (optional)
	' Returns:  The return code of the keyword function. 
	'           If the keyword hasn't been found, returns 1 and raise an error.
	'*********************************************************
	Public Function runKeyword (ByVal strKeyword,ByVal strBrowserID,ByVal strPageID,ByVal strObjectID,ByVal strParam1,ByVal strParam2,ByVal strParam3) ' As Integer
		On Error Resume Next
		Err.Clear
	
		Dim arrReturn ' Array containing the result of the keyword function call
		Dim objCurrent
		Dim strObjectType
	
		'Retrieve Object Type
		strObjectType = getObjectTypeFromKeyword(strKeyword)
	
		'Run Keyword
		Select Case strKeyword
		Case "java_javawindow_activate"
			Set objCurrent = getQTPObject(strObjectType, strBrowserID, strPageID, strObjectID) 
			arrReturn = generic_object_activate(objCurrent, True)
		Case "java_javawindow_exist"
			Set objCurrent = getQTPObject(strObjectType, strBrowserID, strPageID, strObjectID) 
			arrReturn = generic_object_exist(objCurrent, True)
		Case "java_javabutton_click"
			Set objCurrent = getQTPObject(strObjectType, strBrowserID, strPageID, strObjectID) 
			arrReturn = generic_object_click(objCurrent)
		Case "java_javacheckbox_get"
			Set objCurrent = getQTPObject(strObjectType, strBrowserID, strPageID, strObjectID) 
			arrReturn = generic_object_get(objCurrent, strParam1, "checked")
		Case "java_javacheckbox_set"
			Set objCurrent = getQTPObject(strObjectType, strBrowserID, strPageID, strObjectID) 
			arrReturn = generic_object_set(objCurrent, strParam1)
		Case "java_javaedit_get"
			Set objCurrent = getQTPObject(strObjectType, strBrowserID, strPageID, strObjectID) 
			arrReturn = generic_object_get(objCurrent, strParam1, "text")
		Case "java_javaedit_set"
			Set objCurrent = getQTPObject(strObjectType, strBrowserID, strPageID, strObjectID) 
			arrReturn = generic_object_set(objCurrent, strParam1)
		Case "java_javainternalframe_activate"
			Set objCurrent = getQTPObject(strObjectType, strBrowserID, strPageID, strObjectID) 
			arrReturn = generic_object_activate(objCurrent, True)
		Case "java_javalink_click"
			Set objCurrent = getQTPObject(strObjectType, strBrowserID, strPageID, strObjectID) 
			arrReturn = generic_object_click(objCurrent)
		Case "java_javalist_get"
			Set objCurrent = getQTPObject(strObjectType, strBrowserID, strPageID, strObjectID) 
			arrReturn = generic_object_get(objCurrent, strParam1, "value")
		Case "java_javalist_set"
			Set objCurrent = getQTPObject(strObjectType, strBrowserID, strPageID, strObjectID) 
			arrReturn = generic_object_select(objCurrent, strParam1)
		Case "java_javamenu_set"
			Set objCurrent = getQTPObject(strObjectType, strBrowserID, strPageID, strObjectID) 
			arrReturn = generic_object_select(objCurrent, strParam1)
		Case "java_javaobject_click"
			Set objCurrent = getQTPObject(strObjectType, strBrowserID, strPageID, strObjectID) 
			arrReturn = generic_object_click(objCurrent)
		Case "java_javaobject_get"
			Set objCurrent = getQTPObject(strObjectType, strBrowserID, strPageID, strObjectID) 
			arrReturn = generic_object_get(objCurrent, strParam1, "text")
		Case "java_javaradiobutton_get"
			Set objCurrent = getQTPObject(strObjectType, strBrowserID, strPageID, strObjectID) 
			arrReturn = generic_object_get(objCurrent, strParam1, "text")
		Case "java_javaradiobutton_set"
			Set objCurrent = getQTPObject(strObjectType, strBrowserID, strPageID, strObjectID) 
			arrReturn = generic_object_set(objCurrent, strParam1)
		Case "java_javatab_set"
			Set objCurrent = getQTPObject(strObjectType, strBrowserID, strPageID, strObjectID) 
			arrReturn = generic_object_select(objCurrent, strParam1)
		Case "java_javatable_getcell"
			Set objCurrent = getQTPObject(strObjectType, strBrowserID, strPageID, strObjectID) 
			arrReturn = java_javatable_getcell(objCurrent, strParam1, strParam2, strParam3)
		Case "java_javatable_setcell"
			Set objCurrent = getQTPObject(strObjectType, strBrowserID, strPageID, strObjectID) 
			arrReturn = java_javatable_setcell(objCurrent, strParam1, strParam2, strParam3)
		Case "java_javatreeview_set"
			Set objCurrent = getQTPObject(strObjectType, strBrowserID, strPageID, strObjectID) 
			arrReturn = generic_object_select(objCurrent, strParam1)
		Case Else
			Err.Raise 1, "JavaKeyword", strKeyword & " keyword not found"
			arrReturn = Array(1, "", Err.Description)
		End Select
		Set objCurrent = Nothing
	
		runKeyword = arrReturn
	End Function
	
	'*********************************************************
	' Object Repository search
	'*********************************************************
	Private Function getQTPObject(ByVal strObjectType,ByVal strBrowserID,ByVal strPageID,ByVal strObjectID) ' As Object
		On Error Resume Next
		Err.Clear
		Set getQTPObject = Nothing
		If strObjectType = "javawindow" Then
			Set getQTPObject  = JavaWindow(strObjectID)
		Else
			Dim objPage
			'Browser_ID Column contains the JavaWindow name
			Set objPage = JavaWindow(strBrowserID)
			Select Case strObjectType
			Case "javabutton"
				Set getQTPObject  = objPage.JavaButton(strObjectID)
			Case "javacheckbox"
				Set getQTPObject  = objPage.JavaCheckBox(strObjectID)
			Case "javaedit"
				Set getQTPObject  = objPage.JavaEdit(strObjectID)
			Case "javainternalframe"
				Set getQTPObject  = objPage.JavaInternalFrame(strObjectID)
			Case "javalink"
				Set getQTPObject  = objPage.JavaLink(strObjectID)
			Case "javalist"
				Set getQTPObject  = objPage.JavaList(strObjectID)
			Case "javamenu"
				Set getQTPObject  = objPage.JavaMenu(strObjectID)
			Case "javaobject"
				Set getQTPObject  = objPage.JavaObject(strObjectID)
			Case "javaradiobutton"
				Set getQTPObject  = objPage.JavaRadioButton(strObjectID)
			Case "javatab"
				Set getQTPObject  = objPage.JavaTab(strObjectID)
			Case "javatable"
				Set getQTPObject  = objPage.JavaTable(strObjectID)
			Case "javatreeview"
				Set getQTPObject  = objPage.JavaTreeView(strObjectID)
			End Select
			Set objPage = Nothing
		End If
		On Error GoTo 0
		If getQTPObject Is Nothing Then
			Err.Raise 1, "JavaKeyword", strObjectID & " Object of type " & strObjectType & " not found in the Object Repository"
		End If
	End Function
	
	'*********************************************************
	' Keyword implementations
	'*********************************************************
	Private Function java_javatable_getcell(ByRef objTable, ByVal intRow, ByVal intColumn, ByVal strValueID)
		Dim strValue
		strValue = objTable.GetCellData(intRow,  intColumn)
		Call saveRunValue (strValueID, strValue)
		 java_javatable_getcell = Array (0, "", "Value '" & strValue & "' saved with the ValueID '" & strValueID & "'")
	End Function

	Private Function java_javatable_setcell(ByRef objTable, ByVal intRow, ByVal intColumn, ByVal strValue)
		objTable.SelectCell intRow,  intColumn
		objTable.Type strValue & micTab
		java_javatable_setcell = Array (0, "", "Value '" & strValue & "' set in the Cell(" & intRow & ", " & intColumn & ").")
	End Function

End Class
