﻿class DatabaseInfo
{
    [TableInfo[]]$Tables
    [int]$PrimaryKeyMaxSize
    [string]$DatabaseSize
}

class TableInfo2
{
    [string]$SchemaName
    [string]$TableName

    static [bool] IsIgnored([string] $schemaName, [string] $tableName, [TableInfo2[]] $ignoredTables)
    {
        $result = $false

        foreach ($ignoredTable in $ignoredTables)
        {
            if (($ignoredTable.SchemaName -eq $schemaName) -and ($ignoredTable.TableName -eq $tableName))
            {
                $result = $true
                break
            }
        }

        return $result
    }
}

class TableStatistics
{
    [long]$Rows
    [long]$ReservedKB
    [long]$DataKB
    [long]$IndexSize
    [long]$UnusedKB

    [string] ToString() {
        return "$($this.Rows) rows  => [$($this.DataKB) / $($this.ReservedKB) KB, $($this.IndexSize) index KB]"
     }
}

class TableInfo
{
    [string]$SchemaName
    [string]$TableName
    
    [bool]$IsIdentity
    [bool]$IsHistoric
    [bool]$HasHistory
    [string]$HistoryOwner
    [string]$HistoryOwnerSchema
    
    [ColumnInfo[]]$PrimaryKey
    [ColumnInfo[]]$Columns

    [Tablefk[]]$ForeignKeys
    [TableInfo[]]$IsReferencedBy

    [TableStatistics]$Statistics

    [string] ToString() {
      return "$($this.SchemaName).$($this.TableName)"
   }
}

class ColumnInfo
{
    [string]$Name
    [string]$DataType
    [bool]$IsNullable
    [bool]$IsComputed
    [bool]$IsGenerated
}


class TableFk
{
    [string]$Name
    [string]$FkSchema
    [string]$FkTable

    [string]$Schema
    [string]$Table

    [ColumnInfo[]]$FkColumns
    [ColumnInfo[]]$Columns
}