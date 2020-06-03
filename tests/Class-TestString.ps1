class TestString
{
    [string] static ReplaceAtPosition(
        [string] $source,
        [int] $index,
        [string] $newValue
    )
    {
        $newStart = $source.Substring(0, $index)
        $newEnd = $source.Substring($index + $newValue.Length)
        return "$newStart$newValue$newEnd"
    }
    
    [string] static ReplaceAtPosition(
        [string] $source,
        [int] $index,
        [int] $originalLength,
        [string] $newValue
    )
    {
        $newStart = $source.Substring(0, $index)
        $newEnd = $source.Substring($index + $originalLength)
        return "$newStart$newValue$newEnd"
    }

    # [string] static Capitalize(
    #     [string] $source
    # )
    # {
    #     $result = $value.Substring(0, $item.Length - 1) + $value.Substring($item.Length - 1).ToUpper()
    #     $value = $item.Value
    #                 $newValue = $value.Substring(0, $item.Length - 1) + $value.Substring($item.Length - 1).ToUpper()
    #                 $correctedSentence = $correctedSentence.Replace($item.Value, $newValue)
                    
    # }

    # [string] static CapitalizeLast(
    #     [string] $source
    # )
    # {
    #     return $value.Substring(0, $source.Length - 1) + $value.Substring($item.Length - 1).ToUpper()
    # }
}
