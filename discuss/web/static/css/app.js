import React, {StyleSheet, Dimensions, PixelRatio} from "react-native";
const {width, height, scale} = Dimensions.get("window"),
    vw = width / 100,
    vh = height / 100,
    vmin = Math.min(vw, vh),
    vmax = Math.max(vw, vh);

export default StyleSheet.create({
    "body": {
        "fontFamily": "'Open Sans', sans-serif",
        "marginTop": 0
    },
    "h1": {
        "fontFamily": "'Open Sans', sans-serif"
    },
    "h2": {
        "fontFamily": "'Open Sans', sans-serif"
    },
    "h3": {
        "fontFamily": "'Open Sans', sans-serif"
    },
    "h4": {
        "fontFamily": "'Open Sans', sans-serif"
    },
    "h5": {
        "fontFamily": "'Open Sans', sans-serif"
    },
    "h6": {
        "fontFamily": "'Open Sans', sans-serif"
    },
    "nav ul a": {
        "fontSize": 1.5
    },
    "discuss-bg": {
        "backgroundColor": "#b0bdfc"
    },
    "discuss-primary": {
        "backgroundColor": "#bdfcb0"
    },
    "discuss-success": {
        "backgroundColor": "#bdfcb0"
    },
    "discuss-secondary": {
        "backgroundColor": "#fcaebb"
    },
    "discuss-error": {
        "backgroundColor": "#fcaebb"
    }
});