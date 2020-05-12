using namespace System.Collections.Generic
using namespace System.IO
using namespace System.Text.RegularExpressions

class TestLog
{
    static TestLog() {
        [TestLog]::Verbose = $true
        [TestLog]::SuperVerbose = $false 
        [TestLog]::LogContents = $false
    }

    hidden static [bool] $Verbose
    hidden static [bool] $SuperVerbose
    hidden static [bool] $LogContents

    [void] static WriteFilename (
        [FileInfo] $file,
        [string] $header,
        [int] $fileCount)
    {
        if ([TestLog]::SuperVerbose)
        {
            [TestLog]::WriteLine("$($header): $($file.FullName)", "Green", $false)
        }
        elseif ([TestLog]::Verbose)
        {
            if (($fileCount % 20) -eq 0)
            {
                [TestLog]::Write('.')
            }
        }
    }

    [void] static WriteLink([string] $link, [Match] $matchItem)
    {
        if ([TestLog]::SuperVerbose)
        {
            $start = $link.Substring(0, $matchItem.Index)
            [TestLog]::Write("POSSIBLE LINK: '$start", 'DarkGray')
            [TestLog]::Write($matchItem.Value, 'Red')
            
            $end = $link.Substring($matchItem.Index + $matchItem.Length)
            [TestLog]::WriteLine("$end'", 'DarkGray')
        }
    }

    [void] static WriteContents ([string] $output)
    {
        if ([TestLog]::LogContents)
        {
            [TestLog]::WriteLine($output, "Blue", $false)
        }
    }

    [void] static WriteException(
        [object] $exception,
        [FileInfo] $file,
        [string] $functionName
    )
    {
        [TestLog]::WriteLine("EXCEPTION IN $functionName FOR '$($file.FullName)'", 'Red', $false)
        [TestLog]::WriteLine($exception, "RED", $false)
    }

    [void] static WriteError(
        [string] $output
    )
    {
        [TestLog]::WriteLine($output, 'Red', $false)

    }

    [void] static WriteIssue(
        [string] $output
    )
    {
        [TestLog]::WriteLine($output, 'Yellow', $false)
    }
    
    [void] static WriteVerbose(
        [string] $output)
    {
        if ([TestLog]::SuperVerbose -or [TestLog]::Verbose)
        {   
            [TestLog]::WriteLine($output, 'DarkGray', $false)
        }
    }

    [void] static WriteSuperVerbose(
        [string[]] $outputItems
    )
    {
        foreach ($item in $outputItems)
        {
            [TestLog]::WriteSuperVerbose($item)
        }
    }

    [void] static WriteSuperVerbose(
        [string] $output
    )
    {
        if ([TestLog]::SuperVerbose)
        {
            [TestLog]::WriteLine($output, 'DarkGray', $false)
        }
    }

    [void] static Write(
        [string] $output,
        [string] $wordColor
    )
    {
        $wordColor = ($wordColor -eq '') ? "Gray" : $wordColor
        
        try {
            [TestLog]::WriteLine($output, $wordColor, $true)
        }
        catch {
            Write-Host "HERE"            
        }
    }

    [void] static Write(
        [string] $output
    )
    {
        [TestLog]::WriteLine($output, 'Gray', $true)
    }

    [void] static WriteLine(
        [string] $output
    )
    {
        [TestLog]::WriteLine($output, 'Gray', $false)
    }

    [void] static WriteLine(
        [string] $output,
        [System.ConsoleColor] $color,
        [bool] $noNewLine
    )
    {
        $currentColor = [Console]::ForegroundColor
        [Console]::ForegroundColor = $color
        if ($noNewLine)
        {
            [Console]::Write($output)
        }
        else
        {
            [Console]::WriteLine($output)
        }
        [Console]::ForegroundColor = $currentColor
    }
}

