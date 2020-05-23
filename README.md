# SpearDates

SpearDates contains date convience routies reducing common that can be repeated in a projects. 

## Example 
In order to get the Month, Day and Year of a date we need to 

1. Create the flags for Month/Day/Year
2. Get those components from a calendar
3. Extract each element, checking for nil

This code can be simplifed to 

```swift
let currentYear = Date().toMondthDayYear().year
```

[Documentation](https://github.com/kraigspear/SpearDates/blob/gh-pages/docs/index.html)

