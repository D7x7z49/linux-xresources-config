#!/bin/bash

USER_XRESOURCES_HOME="${USER_XRESOURCES_HOME:-$HOME/.config/X11}"
XRESOURCES_DIR="$USER_XRESOURCES_HOME/Xresources.d"

if [ "$#" -ne 3 ]; then
    echo "use: $0 <target> <themes> <new_theme>"
    exit 1
fi

TARGET="$1"
THEMES="$2"
NEW_THEME="$3"

TARGET_FILE="$XRESOURCES_DIR/$TARGET"

if [ ! -f "$TARGET_FILE" ]; then
    echo "erorr: no find $TARGET_FILE"
    exit 1
fi

OLD_INCLUDE="#include \"themes/$THEMES/*\""
NEW_INCLUDE="#include \"themes/$THEMES/$NEW_THEME\""

THEME="$XRESOURCES_DIR/themes/$THEMES/$NEW_THEME"
if [ ! -f "$THEME" ]; then
    echo "erorr: no find $THEME"
    exit 1
fi

if grep -qE "$OLD_INCLUDE" "$TARGET_FILE"; then
    sed -i "s|$OLD_INCLUDE|$NEW_INCLUDE|g" "$TARGET_FILE"
    echo "YES: $OLD_INCLUDE to $NEW_INCLUDE in $TARGET_FILE"
else
    echo "NO: no find $OLD_INCLUDE in $TARGET_FILE"
    exit 1
fi
