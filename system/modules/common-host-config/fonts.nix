{ config, lib, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "SourceCodePro" "Hack" ]; })
    (iosevka.override {
      privateBuildPlan = ''
        [buildPlans.iosevka-custom]
        family = "Iosevka Custom"
        spacing = "normal"
        serifs = "sans"
        no-cv-ss = true
        export-glyph-names = true

          [buildPlans.iosevka-custom.variants]
          inherits = "ss02"

            [buildPlans.iosevka-custom.variants.design]
            capital-d = "more-rounded-serifless"
            capital-g = "toothless-corner-serifless-hooked"
            capital-q = "straight"
            f = "flat-hook"
            j = "flat-hook-serifed"
            l = "diagonal-tailed"
            t = "flat-hook"
            y = "straight-turn"
            long-s = "flat-hook"
            eszet = "longs-s-lig"
            lower-lambda = "straight-turn"
            cyrl-capital-ka = "straight-serifless"
            cyrl-ka = "straight-serifless"
            cyrl-capital-u = "straight-turn"
            one = "base"
            two = "straight-neck"
            four = "closed"
            six = "closed-contour"
            eight = "two-circles"
            nine = "closed-contour"
            asterisk = "hex-low"
            underscore = "low"
            brace = "straight"
            number-sign = "slanted"
            ampersand = "upper-open"
            percent = "rings-continuous-slash"
            bar = "force-upright"
            punctuation-dot = "square"
            #diacritic-dot = "square"

        [buildPlans.iosevka-custom.weights.light]
        shape = 300
        menu = 300
        css = 300

        [buildPlans.iosevka-custom.weights.regular]
        shape = 400
        menu = 400
        css = 400

        [buildPlans.iosevka-custom.weights.bold]
        shape = 700
        menu = 700
        css = 700
      '';
      set = "custom";
    })

    noto-fonts
    emojione
    proggyfonts
    ibm-plex
    vollkorn
    merriweather
    noto-fonts-extra
  ];

  fonts.fontconfig.defaultFonts.monospace = [ "Fira Code" "Hack" ];

}
