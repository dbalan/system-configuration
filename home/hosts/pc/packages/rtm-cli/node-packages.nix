# This file has been generated by node2nix 1.9.0. Do not edit!

{nodeEnv, fetchurl, fetchgit, nix-gitignore, stdenv, lib, globalBuildInputs ? []}:

let
  sources = {
    "ansi-regex-3.0.0" = {
      name = "ansi-regex";
      packageName = "ansi-regex";
      version = "3.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/ansi-regex/-/ansi-regex-3.0.0.tgz";
        sha1 = "ed0317c322064f79466c02966bddb605ab37d998";
      };
    };
    "ansi-styles-3.2.1" = {
      name = "ansi-styles";
      packageName = "ansi-styles";
      version = "3.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/ansi-styles/-/ansi-styles-3.2.1.tgz";
        sha512 = "VT0ZI6kZRdTh8YyJw3SMbYm/u+NqfsAxEpWO0Pf9sq8/e94WxxOpPKx9FR1FlyCtOVDNOQ+8ntlqFxiRc+r5qA==";
      };
    };
    "chalk-2.4.2" = {
      name = "chalk";
      packageName = "chalk";
      version = "2.4.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/chalk/-/chalk-2.4.2.tgz";
        sha512 = "Mti+f9lpJNcwF4tWV8/OrTTtF1gZi+f8FqlyAdouralcFWFQWF2+NgCHShjkCb+IFBLq9buZwE1xckQU4peSuQ==";
      };
    };
    "cli-cursor-2.1.0" = {
      name = "cli-cursor";
      packageName = "cli-cursor";
      version = "2.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/cli-cursor/-/cli-cursor-2.1.0.tgz";
        sha1 = "b35dac376479facc3e94747d41d0d0f5238ffcb5";
      };
    };
    "cli-spinners-1.3.1" = {
      name = "cli-spinners";
      packageName = "cli-spinners";
      version = "1.3.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/cli-spinners/-/cli-spinners-1.3.1.tgz";
        sha512 = "1QL4544moEsDVH9T/l6Cemov/37iv1RtoKf7NJ04A60+4MREXNfx/QvavbH6QoGdsD4N4Mwy49cmaINR/o2mdg==";
      };
    };
    "cli-table3-0.5.1" = {
      name = "cli-table3";
      packageName = "cli-table3";
      version = "0.5.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/cli-table3/-/cli-table3-0.5.1.tgz";
        sha512 = "7Qg2Jrep1S/+Q3EceiZtQcDPWxhAvBw+ERf1162v4sikJrvojMHFqXt8QIVha8UlH9rgU0BeWPytZ9/TzYqlUw==";
      };
    };
    "color-convert-1.9.3" = {
      name = "color-convert";
      packageName = "color-convert";
      version = "1.9.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/color-convert/-/color-convert-1.9.3.tgz";
        sha512 = "QfAUtd+vFdAtFQcC8CCyYt1fYWxSqAiK2cSD6zDB8N3cpsEBAvRxp9zOGg6G/SHHJYAT88/az/IuDGALsNVbGg==";
      };
    };
    "color-name-1.1.3" = {
      name = "color-name";
      packageName = "color-name";
      version = "1.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/color-name/-/color-name-1.1.3.tgz";
        sha1 = "a7d0558bd89c42f795dd42328f740831ca53bc25";
      };
    };
    "colors-1.4.0" = {
      name = "colors";
      packageName = "colors";
      version = "1.4.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/colors/-/colors-1.4.0.tgz";
        sha512 = "a+UqTh4kgZg/SlGvfbzDHpgRu7AAQOmmqRHJnxhRZICKFUT91brVhNNt58CMWU9PsBbv3PDCZUHbVxuDiH2mtA==";
      };
    };
    "commander-2.20.3" = {
      name = "commander";
      packageName = "commander";
      version = "2.20.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/commander/-/commander-2.20.3.tgz";
        sha512 = "GpVkmM8vF2vQUkj2LvZmD35JxeJOLCwJ9cUkugyk2nuhbv3+mJvpLYYt+0+USMxE+oj+ey/lJEnhZw75x/OMcQ==";
      };
    };
    "copy-paste-1.3.0" = {
      name = "copy-paste";
      packageName = "copy-paste";
      version = "1.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/copy-paste/-/copy-paste-1.3.0.tgz";
        sha1 = "a7e6c4a1c28fdedf2b081e72b97df2ef95f471ed";
      };
    };
    "dateformat-3.0.3" = {
      name = "dateformat";
      packageName = "dateformat";
      version = "3.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/dateformat/-/dateformat-3.0.3.tgz";
        sha512 = "jyCETtSl3VMZMWeRo7iY1FL19ges1t55hMo5yaam4Jrsm5EPL89UQkoQRyiI+Yf4k8r2ZpdngkV8hr1lIdjb3Q==";
      };
    };
    "deepmerge-2.2.1" = {
      name = "deepmerge";
      packageName = "deepmerge";
      version = "2.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/deepmerge/-/deepmerge-2.2.1.tgz";
        sha512 = "R9hc1Xa/NOBi9WRVUWg19rl1UB7Tt4kuPd+thNJgFZoxXsTz7ncaPaeIm+40oSGuP33DfMb4sZt1QIGiJzC4EA==";
      };
    };
    "define-property-1.0.0" = {
      name = "define-property";
      packageName = "define-property";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/define-property/-/define-property-1.0.0.tgz";
        sha1 = "769ebaaf3f4a63aad3af9e8d304c9bbe79bfb0e6";
      };
    };
    "escape-string-regexp-1.0.5" = {
      name = "escape-string-regexp";
      packageName = "escape-string-regexp";
      version = "1.0.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/escape-string-regexp/-/escape-string-regexp-1.0.5.tgz";
        sha1 = "1b61c0562190a8dff6ae3bb2cf0200ca130b86d4";
      };
    };
    "has-flag-3.0.0" = {
      name = "has-flag";
      packageName = "has-flag";
      version = "3.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/has-flag/-/has-flag-3.0.0.tgz";
        sha1 = "b5d454dc2199ae225699f3467e5a07f3b955bafd";
      };
    };
    "iconv-lite-0.4.24" = {
      name = "iconv-lite";
      packageName = "iconv-lite";
      version = "0.4.24";
      src = fetchurl {
        url = "https://registry.npmjs.org/iconv-lite/-/iconv-lite-0.4.24.tgz";
        sha512 = "v3MXnZAcvnywkTUEZomIActle7RXXeedOR31wwl7VlyoXO4Qi9arvSenNQWne1TcRwhCL1HwLI21bEqdpj8/rA==";
      };
    };
    "is-accessor-descriptor-1.0.0" = {
      name = "is-accessor-descriptor";
      packageName = "is-accessor-descriptor";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-accessor-descriptor/-/is-accessor-descriptor-1.0.0.tgz";
        sha512 = "m5hnHTkcVsPfqx3AKlyttIPb7J+XykHvJP2B9bZDjlhLIoEq4XoK64Vg7boZlVWYK6LUY94dYPEE7Lh0ZkZKcQ==";
      };
    };
    "is-buffer-1.1.6" = {
      name = "is-buffer";
      packageName = "is-buffer";
      version = "1.1.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-buffer/-/is-buffer-1.1.6.tgz";
        sha512 = "NcdALwpXkTm5Zvvbk7owOUSvVvBKDgKP5/ewfXEznmQFfs4ZRmanOeKBTjRVjka3QFoN6XJ+9F3USqfHqTaU5w==";
      };
    };
    "is-data-descriptor-1.0.0" = {
      name = "is-data-descriptor";
      packageName = "is-data-descriptor";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-data-descriptor/-/is-data-descriptor-1.0.0.tgz";
        sha512 = "jbRXy1FmtAoCjQkVmIVYwuuqDFUbaOeDjmed1tOGPrsMhtJA4rD9tkgA0F1qJ3gRFRXcHYVkdeaP50Q5rE/jLQ==";
      };
    };
    "is-descriptor-1.0.2" = {
      name = "is-descriptor";
      packageName = "is-descriptor";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-descriptor/-/is-descriptor-1.0.2.tgz";
        sha512 = "2eis5WqQGV7peooDyLmNEPUrps9+SXX5c9pL3xEB+4e9HnGuDa7mB7kHxHw4CbqS9k1T2hOH3miL8n8WtiYVtg==";
      };
    };
    "is-fullwidth-code-point-2.0.0" = {
      name = "is-fullwidth-code-point";
      packageName = "is-fullwidth-code-point";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-fullwidth-code-point/-/is-fullwidth-code-point-2.0.0.tgz";
        sha1 = "a3b30a5c4f199183167aaab93beefae3ddfb654f";
      };
    };
    "is-number-3.0.0" = {
      name = "is-number";
      packageName = "is-number";
      version = "3.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-number/-/is-number-3.0.0.tgz";
        sha1 = "24fd6201a4782cf50561c810276afc7d12d71195";
      };
    };
    "is-wsl-1.1.0" = {
      name = "is-wsl";
      packageName = "is-wsl";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-wsl/-/is-wsl-1.1.0.tgz";
        sha1 = "1f16e4aa22b04d1336b66188a66af3c600c3a66d";
      };
    };
    "kind-of-3.2.2" = {
      name = "kind-of";
      packageName = "kind-of";
      version = "3.2.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/kind-of/-/kind-of-3.2.2.tgz";
        sha1 = "31ea21a734bab9bbb0f32466d893aea51e4a3c64";
      };
    };
    "kind-of-6.0.3" = {
      name = "kind-of";
      packageName = "kind-of";
      version = "6.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/kind-of/-/kind-of-6.0.3.tgz";
        sha512 = "dcS1ul+9tmeD95T+x28/ehLgd9mENa3LsvDTtzm3vyBEO7RPptvAD+t44WVXaUjTBRcrpFeFlC8WCruUR456hw==";
      };
    };
    "log-symbols-2.2.0" = {
      name = "log-symbols";
      packageName = "log-symbols";
      version = "2.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/log-symbols/-/log-symbols-2.2.0.tgz";
        sha512 = "VeIAFslyIerEJLXHziedo2basKbMKtTw3vfn5IzG0XTjhAVEJyNHnL2p7vc+wBDSdQuUpNw3M2u6xb9QsAY5Eg==";
      };
    };
    "mimic-fn-1.2.0" = {
      name = "mimic-fn";
      packageName = "mimic-fn";
      version = "1.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/mimic-fn/-/mimic-fn-1.2.0.tgz";
        sha512 = "jf84uxzwiuiIVKiOLpfYk7N46TSy8ubTonmneY9vrpHNAnp0QBt2BxWV9dO3/j+BoVAb+a5G6YDPW3M5HOdMWQ==";
      };
    };
    "object-assign-4.1.1" = {
      name = "object-assign";
      packageName = "object-assign";
      version = "4.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/object-assign/-/object-assign-4.1.1.tgz";
        sha1 = "2109adc7965887cfc05cbbd442cac8bfbb360863";
      };
    };
    "onetime-2.0.1" = {
      name = "onetime";
      packageName = "onetime";
      version = "2.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/onetime/-/onetime-2.0.1.tgz";
        sha1 = "067428230fd67443b2794b22bba528b6867962d4";
      };
    };
    "opn-5.5.0" = {
      name = "opn";
      packageName = "opn";
      version = "5.5.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/opn/-/opn-5.5.0.tgz";
        sha512 = "PqHpggC9bLV0VeWcdKhkpxY+3JTzetLSqTCWL/z/tFIbI6G8JCjondXklT1JinczLz2Xib62sSp0T/gKT4KksA==";
      };
    };
    "ora-1.4.0" = {
      name = "ora";
      packageName = "ora";
      version = "1.4.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/ora/-/ora-1.4.0.tgz";
        sha512 = "iMK1DOQxzzh2MBlVsU42G80mnrvUhqsMh74phHtDlrcTZPK0pH6o7l7DRshK+0YsxDyEuaOkziVdvM3T0QTzpw==";
      };
    };
    "restore-cursor-2.0.0" = {
      name = "restore-cursor";
      packageName = "restore-cursor";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/restore-cursor/-/restore-cursor-2.0.0.tgz";
        sha1 = "9f7ee287f82fd326d4fd162923d62129eee0dfaf";
      };
    };
    "rtm-api-1.3.1" = {
      name = "rtm-api";
      packageName = "rtm-api";
      version = "1.3.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/rtm-api/-/rtm-api-1.3.1.tgz";
        sha512 = "bGeRETUbaJDW4g0dM/q04vir9f6dILPly4nl08Nrs1PxsouBisKLy75i0Tn0v8j3XozNARqRpMvVUots/DpD1g==";
      };
    };
    "safer-buffer-2.1.2" = {
      name = "safer-buffer";
      packageName = "safer-buffer";
      version = "2.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/safer-buffer/-/safer-buffer-2.1.2.tgz";
        sha512 = "YZo3K82SD7Riyi0E1EQPojLz7kpepnSQI9IyPbHHg1XXXevb5dJI7tpyN2ADxGcQbHG7vcyRHk0cbwqcQriUtg==";
      };
    };
    "signal-exit-3.0.3" = {
      name = "signal-exit";
      packageName = "signal-exit";
      version = "3.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/signal-exit/-/signal-exit-3.0.3.tgz";
        sha512 = "VUJ49FC8U1OxwZLxIbTTrDvLnf/6TDgxZcK8wxR8zs13xpx7xbG60ndBlhNrFi2EMuFRoeDoJO7wthSLq42EjA==";
      };
    };
    "string-width-2.1.1" = {
      name = "string-width";
      packageName = "string-width";
      version = "2.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/string-width/-/string-width-2.1.1.tgz";
        sha512 = "nOqH59deCq9SRHlxq1Aw85Jnt4w6KvLKqWVik6oA9ZklXLNIOlqg4F2yrT1MVaTjAqvVwdfeZ7w7aCvJD7ugkw==";
      };
    };
    "strip-ansi-4.0.0" = {
      name = "strip-ansi";
      packageName = "strip-ansi";
      version = "4.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/strip-ansi/-/strip-ansi-4.0.0.tgz";
        sha1 = "a8479022eb1ac368a871389b635262c505ee368f";
      };
    };
    "supports-color-5.5.0" = {
      name = "supports-color";
      packageName = "supports-color";
      version = "5.5.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/supports-color/-/supports-color-5.5.0.tgz";
        sha512 = "QjVjwdXIt408MIiAqCX4oUKsgU2EqAGzs2Ppkm4aQYbjm+ZEWEcW4SfFNTr4uMNZma0ey4f5lgLrkB0aX0QMow==";
      };
    };
    "sync-exec-0.6.2" = {
      name = "sync-exec";
      packageName = "sync-exec";
      version = "0.6.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/sync-exec/-/sync-exec-0.6.2.tgz";
        sha1 = "717d22cc53f0ce1def5594362f3a89a2ebb91105";
      };
    };
    "window-size-1.1.1" = {
      name = "window-size";
      packageName = "window-size";
      version = "1.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/window-size/-/window-size-1.1.1.tgz";
        sha512 = "5D/9vujkmVQ7pSmc0SCBmHXbkv6eaHwXEx65MywhmUMsI8sGqJ972APq1lotfcwMKPFLuCFfL8xGHLIp7jaBmA==";
      };
    };
  };
in
{
  rtm-cli = nodeEnv.buildNodePackage {
    name = "rtm-cli";
    packageName = "rtm-cli";
    version = "1.5.1";
    src = fetchurl {
      url = "https://registry.npmjs.org/rtm-cli/-/rtm-cli-1.5.1.tgz";
      sha512 = "0ctx6WjR1/hGAPsAmZKMGoZ0WF/6D0u6i/wX8+mjsc6DhJvVGk4Y3Q3DS+J9kaMXpiMdrFpBzwpaegKjSgcXIw==";
    };
    dependencies = [
      sources."ansi-regex-3.0.0"
      sources."ansi-styles-3.2.1"
      sources."chalk-2.4.2"
      sources."cli-cursor-2.1.0"
      sources."cli-spinners-1.3.1"
      sources."cli-table3-0.5.1"
      sources."color-convert-1.9.3"
      sources."color-name-1.1.3"
      sources."colors-1.4.0"
      sources."commander-2.20.3"
      sources."copy-paste-1.3.0"
      sources."dateformat-3.0.3"
      sources."deepmerge-2.2.1"
      sources."define-property-1.0.0"
      sources."escape-string-regexp-1.0.5"
      sources."has-flag-3.0.0"
      sources."iconv-lite-0.4.24"
      sources."is-accessor-descriptor-1.0.0"
      sources."is-buffer-1.1.6"
      sources."is-data-descriptor-1.0.0"
      sources."is-descriptor-1.0.2"
      sources."is-fullwidth-code-point-2.0.0"
      (sources."is-number-3.0.0" // {
        dependencies = [
          sources."kind-of-3.2.2"
        ];
      })
      sources."is-wsl-1.1.0"
      sources."kind-of-6.0.3"
      sources."log-symbols-2.2.0"
      sources."mimic-fn-1.2.0"
      sources."object-assign-4.1.1"
      sources."onetime-2.0.1"
      sources."opn-5.5.0"
      sources."ora-1.4.0"
      sources."restore-cursor-2.0.0"
      sources."rtm-api-1.3.1"
      sources."safer-buffer-2.1.2"
      sources."signal-exit-3.0.3"
      sources."string-width-2.1.1"
      sources."strip-ansi-4.0.0"
      sources."supports-color-5.5.0"
      sources."sync-exec-0.6.2"
      sources."window-size-1.1.1"
    ];
    buildInputs = globalBuildInputs;
    meta = {
      description = "RTM CLI";
      homepage = "https://github.com/dwaring87/rtm-cli#readme";
      license = "MIT";
    };
    production = true;
    bypassCache = true;
    reconstructLock = true;
  };
}
