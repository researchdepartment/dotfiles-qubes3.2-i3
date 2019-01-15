#!/bin/sh

# As stated, we only want the first line, thus we use head
ACPI=`acpi -V | head -n 1`

# Different information to return
STATE=`echo -n "$ACPI" | awk '{print substr(tolower($3), 0, length($3)-1)}'`
AMOUNT=`echo -n "$ACPI" | awk '{print substr($4, 0, length($4)-1)}'`
TIME=`echo -n "$ACPI" | awk '{print $5}'`

if [ "$STATE" == "charging" ]
then
STATE=">"
else
STATE="<"
fi

echo "$STATE$AMOUNT ($TIME)"

exit 0