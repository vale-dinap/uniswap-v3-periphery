// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.8.4;

import '@openzeppelin/contracts/utils/Strings.sol';
import '@uniswap/v3-core/contracts/libraries/BitMath.sol';
import '../external/Base64.sol';

/// @title NFTSVG
/// @notice Provides a function for generating an SVG associated with a Uniswap NFT
library NFTSVG {
    using Strings for uint256;

    bytes32 constant curve1 = 'M1 1C41 41 105 105 145 145';
    bytes32 constant curve2 = 'M1 1C33 49 97 113 145 145';
    bytes32 constant curve3 = 'M1 1C33 57 89 113 145 145';
    bytes32 constant curve4 = 'M1 1C25 65 81 121 145 145';
    bytes32 constant curve5 = 'M1 1C17 73 73 129 145 145';
    bytes32 constant curve6 = 'M1 1C9 81 65 137 145 145';
    bytes32 constant curve7 = 'M1 1C1 89 57.5 145 145 145';
    bytes32 constant curve8 = 'M1 1C1 97 49 145 145 145';

    struct SVGParams {
        bytes quoteToken;
        bytes baseToken;
        address poolAddress;
        bytes quoteTokenSymbol;
        bytes baseTokenSymbol;
        string feeTier;
        int24 tickLower;
        int24 tickUpper;
        int24 tickSpacing;
        int8 overRange;
        uint256 tokenId;
        bytes color0;
        bytes color1;
        bytes color2;
        bytes color3;
        bytes x1;
        bytes y1;
        bytes x2;
        bytes y2;
        bytes x3;
        bytes y3;
    }

    function generateSVG(SVGParams memory params) internal pure returns (bytes memory svg) {
        /*
        address: "0xe8ab59d3bcde16a29912de83a90eb39628cfc163",
        msg: "Forged in SVG for Uniswap in 2021 by 0xe8ab59d3bcde16a29912de83a90eb39628cfc163",
        sig: "0x2df0e99d9cbfec33a705d83f75666d98b22dea7c1af412c584f7d626d83f02875993df740dc87563b9c73378f8462426da572d7989de88079a382ad96c57b68d1b",
        version: "2"
        */
        return abi.encodePacked(
            generateSVGDefs(params),
            generateSVGBorderText(
                params.quoteToken,
                params.baseToken,
                params.quoteTokenSymbol,
                params.baseTokenSymbol
            ),
            generateSVGCardMantle(params.quoteTokenSymbol, params.baseTokenSymbol, params.feeTier),
            generageSvgCurve(params.tickLower, params.tickUpper, params.tickSpacing, params.overRange),
            generateSVGPositionDataAndLocationCurve(
                params.tokenId.toString(),
                params.tickLower,
                params.tickUpper
            ),
            generateSVGRareSparkle(params.tokenId, params.poolAddress),
            '</svg>'
        );
    }

    function generateSVGDefs(SVGParams memory params) private pure returns (bytes memory svg) {
        {
            svg = bytes.concat(
                '<svg width="290" height="500" viewBox="0 0 290 500" xmlns="http://www.w3.org/2000/svg"',
                " xmlns:xlink='http://www.w3.org/1999/xlink'>",
                '<defs>',
                '<filter id="f1"><feImage result="p0" xlink:href="data:image/svg+xml;base64,',
                bytes(
                    Base64.encode(
                        abi.encodePacked(
                            "<svg width='290' height='500' viewBox='0 0 290 500' xmlns='http://www.w3.org/2000/svg'><rect width='290px' height='500px' fill='#",
                            params.color0,
                            "'/></svg>"
                        )
                    )
                ),
                '"/><feImage result="p1" xlink:href="data:image/svg+xml;base64,');
        }
        {
            svg = bytes.concat(
                svg,
                bytes(
                    Base64.encode(
                        abi.encodePacked(
                            "<svg width='290' height='500' viewBox='0 0 290 500' xmlns='http://www.w3.org/2000/svg'><circle cx='",
                            params.x1,
                            "' cy='",
                            params.y1,
                            "' r='120px' fill='#",
                            params.color1,
                            "'/></svg>"
                        )
                    )
                ),
                '"/><feImage result="p2" xlink:href="data:image/svg+xml;base64,'
            );
        }
        {
            svg = bytes.concat(
                svg,
                bytes(
                    Base64.encode(
                        abi.encodePacked(
                            "<svg width='290' height='500' viewBox='0 0 290 500' xmlns='http://www.w3.org/2000/svg'><circle cx='",
                            params.x2,
                            "' cy='",
                            params.y2,
                            "' r='120px' fill='#",
                            params.color2,
                            "'/></svg>"
                        )
                    )
                ),
                '" />',
                '<feImage result="p3" xlink:href="data:image/svg+xml;base64,'
            );
        }
        {
            svg = bytes.concat(
                svg,
                bytes(
                    Base64.encode(
                        abi.encodePacked(
                            "<svg width='290' height='500' viewBox='0 0 290 500' xmlns='http://www.w3.org/2000/svg'><circle cx='",
                            params.x3,
                            "' cy='",
                            params.y3,
                            "' r='100px' fill='#",
                            params.color3,
                            "'/></svg>"
                        )
                    )
                ),
                '" /><feBlend mode="overlay" in="p0" in2="p1" /><feBlend mode="exclusion" in2="p2" /><feBlend mode="overlay" in2="p3" result="blendOut" /><feGaussianBlur ',
                'in="blendOut" stdDeviation="42" /></filter> <clipPath id="corners"><rect width="290" height="500" rx="42" ry="42" /></clipPath>'
            );
        }
        {
            svg = bytes.concat(
                svg,
                '<path id="text-path-a" d="M40 12 H250 A28 28 0 0 1 278 40 V460 A28 28 0 0 1 250 488 H40 A28 28 0 0 1 12 460 V40 A28 28 0 0 1 40 12 z" />',
                '<path id="minimap" d="M234 444C234 457.949 242.21 463 253 463" />',
                '<filter id="top-region-blur"><feGaussianBlur in="SourceGraphic" stdDeviation="24" /></filter>',
                '<linearGradient id="grad-up" x1="1" x2="0" y1="1" y2="0"><stop offset="0.0" stop-color="white" stop-opacity="1" />',
                '<stop offset=".9" stop-color="white" stop-opacity="0" /></linearGradient>',
                '<linearGradient id="grad-down" x1="0" x2="1" y1="0" y2="1"><stop offset="0.0" stop-color="white" stop-opacity="1" /><stop offset="0.9" stop-color="white" stop-opacity="0" /></linearGradient>',
                '<mask id="fade-up" maskContentUnits="objectBoundingBox"><rect width="1" height="1" fill="url(#grad-up)" /></mask>',
                '<mask id="fade-down" maskContentUnits="objectBoundingBox"><rect width="1" height="1" fill="url(#grad-down)" /></mask>',
                '<mask id="none" maskContentUnits="objectBoundingBox"><rect width="1" height="1" fill="white" /></mask>'
            );
        }
        {
            svg = bytes.concat(
                svg,
                '<linearGradient id="grad-symbol"><stop offset="0.7" stop-color="white" stop-opacity="1" /><stop offset=".95" stop-color="white" stop-opacity="0" /></linearGradient>',
                '<mask id="fade-symbol" maskContentUnits="userSpaceOnUse"><rect width="290px" height="200px" fill="url(#grad-symbol)" /></mask></defs>',
                '<g clip-path="url(#corners)">',
                '<rect fill="',
                params.color0,
                '" x="0px" y="0px" width="290px" height="500px" />',
                '<rect style="filter: url(#f1)" x="0px" y="0px" width="290px" height="500px" />',
                ' <g style="filter:url(#top-region-blur); transform:scale(1.5); transform-origin:center top;">',
                '<rect fill="none" x="0px" y="0px" width="290px" height="500px" />',
                '<ellipse cx="50%" cy="0px" rx="180px" ry="120px" fill="#000" opacity="0.85" /></g>',
                '<rect x="0" y="0" width="290" height="500" rx="42" ry="42" fill="rgba(0,0,0,0)" stroke="rgba(255,255,255,0.2)" /></g>'
            );
        }
    }

    function generateSVGBorderText(
        bytes memory quoteToken,
        bytes memory baseToken,
        bytes memory quoteTokenSymbol,
        bytes memory baseTokenSymbol
    ) private pure returns (bytes memory svg) {
        {
            svg = bytes.concat(
                '<text text-rendering="optimizeSpeed">',
                '<textPath startOffset="-100%" fill="white" font-family="\'Courier New\', monospace" font-size="10px" xlink:href="#text-path-a">',
                baseToken,
                unicode' • ',
                baseTokenSymbol,
                ' <animate additive="sum" attributeName="startOffset" from="0%" to="100%" begin="0s" dur="30s" repeatCount="indefinite" />',
                '</textPath> <textPath startOffset="0%" fill="white" font-family="\'Courier New\', monospace" font-size="10px" xlink:href="#text-path-a">',
                baseToken,
                unicode' • '
            );
        }
        {
            svg = bytes.concat(
                svg,
                baseTokenSymbol,
                ' <animate additive="sum" attributeName="startOffset" from="0%" to="100%" begin="0s" dur="30s" repeatCount="indefinite" /> </textPath>',
                '<textPath startOffset="50%" fill="white" font-family="\'Courier New\', monospace" font-size="10px" xlink:href="#text-path-a">',
                quoteToken,
                unicode' • ',
                quoteTokenSymbol,
                ' <animate additive="sum" attributeName="startOffset" from="0%" to="100%" begin="0s" dur="30s"',
                ' repeatCount="indefinite" /></textPath><textPath startOffset="-50%" fill="white" font-family="\'Courier New\', monospace" font-size="10px" xlink:href="#text-path-a">',
                quoteToken,
                unicode' • ',
                quoteTokenSymbol,
                ' <animate additive="sum" attributeName="startOffset" from="0%" to="100%" begin="0s" dur="30s" repeatCount="indefinite" /></textPath></text>'
            );
        }
    }

    function generateSVGCardMantle(
        bytes memory quoteTokenSymbol,
        bytes memory baseTokenSymbol,
        string memory feeTier
    ) private pure returns (bytes memory svg) {
        svg = abi.encodePacked(
            '<g mask="url(#fade-symbol)"><rect fill="none" x="0px" y="0px" width="290px" height="200px" /> <text y="70px" x="32px" fill="white" font-family="\'Courier New\', monospace" font-weight="200" font-size="36px">',
            quoteTokenSymbol,
            '/',
            baseTokenSymbol,
            '</text><text y="115px" x="32px" fill="white" font-family="\'Courier New\', monospace" font-weight="200" font-size="36px">',
            feeTier,
            '</text></g>',
            '<rect x="16" y="16" width="258" height="468" rx="26" ry="26" fill="rgba(0,0,0,0)" stroke="rgba(255,255,255,0.2)" />'
        );
    }

    function generageSvgCurve(
        int24 tickLower,
        int24 tickUpper,
        int24 tickSpacing,
        int8 overRange
    ) private pure returns (bytes memory svg) {
        bytes memory fade = bytes(overRange == 1 ? '#fade-up' : overRange == -1 ? '#fade-down' : '#none');
        bytes32 curve = getCurve(tickLower, tickUpper, tickSpacing);
        {
            svg = bytes.concat(
                '<g mask="url(',
                fade,
                ')"',
                ' style="transform:translate(72px,189px)">'
                '<rect x="-16px" y="-16px" width="180px" height="180px" fill="none" />'
                '<path d="',
                curve,
                '" stroke="rgba(0,0,0,0.3)" stroke-width="32px" fill="none" stroke-linecap="round" />'
            );
        }
        {
            svg = bytes.concat(
                svg,
                '</g><g mask="url(',
                fade,
                ')"',
                ' style="transform:translate(72px,189px)">',
                '<rect x="-16px" y="-16px" width="180px" height="180px" fill="none" />',
                '<path d="',
                curve,
                '" stroke="rgba(255,255,255,1)" fill="none" stroke-linecap="round" /></g>',
                generateSVGCurveCircle(overRange)
            );
        }
    }

    function getCurve(
        int24 tickLower,
        int24 tickUpper,
        int24 tickSpacing
    ) internal pure returns (bytes32 curve) {
        int24 tickRange = (tickUpper - tickLower) / tickSpacing;
        if (tickRange <= 4) {
            curve = curve1;
        } else if (tickRange <= 8) {
            curve = curve2;
        } else if (tickRange <= 16) {
            curve = curve3;
        } else if (tickRange <= 32) {
            curve = curve4;
        } else if (tickRange <= 64) {
            curve = curve5;
        } else if (tickRange <= 128) {
            curve = curve6;
        } else if (tickRange <= 256) {
            curve = curve7;
        } else {
            curve = curve8;
        }
    }

    function generateSVGCurveCircle(int8 overRange) internal pure returns (bytes memory svg) {
        bytes2 curvex1 = '73';
        bytes3 curvey1 = '190';
        bytes3 curvex2 = '217';
        bytes3 curvey2 = '334';
        if (overRange == 1 || overRange == -1) {
            svg = bytes.concat(
                '<circle cx="',
                overRange == -1 ? curvex1 : curvex2,
                'px" cy="',
                overRange == -1 ? curvey1 : curvey2,
                'px" r="4px" fill="white" /><circle cx="',
                overRange == -1 ? curvex1 : curvex2,
                'px" cy="',
                overRange == -1 ? curvey1 : curvey2,
                'px" r="24px" fill="none" stroke="white" />'
            );
        } else {
            svg = bytes.concat(
                '<circle cx="',
                curvex1,
                'px" cy="',
                curvey1,
                'px" r="4px" fill="white" />',
                '<circle cx="',
                curvex2,
                'px" cy="',
                curvey2,
                'px" r="4px" fill="white" />'
            );
        }
    }

    struct SVGPosDataAndLocCurveBuffer {
        bytes tickLowerStr;
        bytes tickUpperStr;
        uint8 str1length;
        uint8 str2length;
        uint8 str3length;
        bytes2 xCoord;
        bytes5 yCoord;
    }

    function generateSVGPositionDataAndLocationCurve(
        string memory tokenId,
        int24 tickLower,
        int24 tickUpper
    ) private pure returns (bytes memory svg) {
        SVGPosDataAndLocCurveBuffer memory b;
        b.tickLowerStr = tickToString(tickLower);
        b.tickUpperStr = tickToString(tickUpper);
        b.str1length = uint8(bytes(tokenId).length + 4);
        b.str2length = uint8(bytes(b.tickLowerStr).length + 10);
        b.str3length = uint8(bytes(b.tickUpperStr).length + 10);
        (b.xCoord, b.yCoord) = rangeLocation(tickLower, tickUpper);
        {
            svg = abi.encodePacked(
                ' <g style="transform:translate(29px, 384px)">',
                '<rect width="',
                uint256(7 * (b.str1length + 4)).toString(),
                'px" height="26px" rx="8px" ry="8px" fill="rgba(0,0,0,0.6)" />',
                '<text x="12px" y="17px" font-family="\'Courier New\', monospace" font-size="12px" fill="white"><tspan fill="rgba(255,255,255,0.6)">ID: </tspan>',
                tokenId,
                '</text></g>',
                ' <g style="transform:translate(29px, 414px)">',
                '<rect width="',
                uint256(7 * (b.str2length + 4)).toString()
            );
        }
        {
            svg = abi.encodePacked(
                svg,
                'px" height="26px" rx="8px" ry="8px" fill="rgba(0,0,0,0.6)" />',
                '<text x="12px" y="17px" font-family="\'Courier New\', monospace" font-size="12px" fill="white"><tspan fill="rgba(255,255,255,0.6)">Min Tick: </tspan>',
                b.tickLowerStr,
                '</text></g>',
                ' <g style="transform:translate(29px, 444px)">',
                '<rect width="',
                uint256(7 * (b.str3length + 4)).toString(),
                'px" height="26px" rx="8px" ry="8px" fill="rgba(0,0,0,0.6)" />',
                '<text x="12px" y="17px" font-family="\'Courier New\', monospace" font-size="12px" fill="white"><tspan fill="rgba(255,255,255,0.6)">Max Tick: </tspan>'
            );
        }
        {
            svg = abi.encodePacked(
                svg,
                b.tickUpperStr,
                '</text></g>'
                '<g style="transform:translate(226px, 433px)">',
                '<rect width="36px" height="36px" rx="8px" ry="8px" fill="none" stroke="rgba(255,255,255,0.2)" />',
                '<path stroke-linecap="round" d="M8 9C8.00004 22.9494 16.2099 28 27 28" fill="none" stroke="white" />',
                '<circle style="transform:translate3d(',
                b.xCoord,
                'px, ',
                b.yCoord,
                'px, 0px)" cx="0px" cy="0px" r="4px" fill="white"/></g>'
            );
        }
    }

    function tickToString(int24 tick) private pure returns (bytes memory) {
        string memory sign = '';
        if (tick < 0) {
            tick = tick * -1;
            sign = '-';
        }
        return abi.encodePacked(sign, uint256(int256(tick)).toString());
    }

    function rangeLocation(int24 tickLower, int24 tickUpper) internal pure returns (bytes2, bytes5) {
        int24 midPoint = (tickLower + tickUpper) / 2;
        if (midPoint < -125_000) {
            return ('8', '7');
        } else if (midPoint < -75_000) {
            return ('8', '10.5');
        } else if (midPoint < -25_000) {
            return ('8', '14.25');
        } else if (midPoint < -5_000) {
            return ('10', '18');
        } else if (midPoint < 0) {
            return ('11', '21');
        } else if (midPoint < 5_000) {
            return ('13', '23');
        } else if (midPoint < 25_000) {
            return ('15', '25');
        } else if (midPoint < 75_000) {
            return ('18', '26');
        } else if (midPoint < 125_000) {
            return ('21', '27');
        } else {
            return ('24', '27');
        }
    }

    function generateSVGRareSparkle(uint256 tokenId, address poolAddress) private pure returns (bytes memory svg) {
        if (isRare(tokenId, poolAddress)) {
            svg = bytes.concat(
                '<g style="transform:translate(226px, 392px)"><rect width="36px" height="36px" rx="8px" ry="8px" fill="none" stroke="rgba(255,255,255,0.2)" />',
                '<g><path style="transform:translate(6px,6px)" d="M12 0L12.6522 9.56587L18 1.6077L13.7819 10.2181L22.3923 6L14.4341 ',
                '11.3478L24 12L14.4341 12.6522L22.3923 18L13.7819 13.7819L18 22.3923L12.6522 14.4341L12 24L11.3478 14.4341L6 22.39',
                '23L10.2181 13.7819L1.6077 18L9.56587 12.6522L0 12L9.56587 11.3478L1.6077 6L10.2181 10.2181L6 1.6077L11.3478 9.56587L12 0Z" fill="white" />',
                '<animateTransform attributeName="transform" type="rotate" from="0 18 18" to="360 18 18" dur="10s" repeatCount="indefinite"/></g></g>'
            );
        }
    }

    function isRare(uint256 tokenId, address poolAddress) internal pure returns (bool) {
        bytes32 h = keccak256(abi.encodePacked(tokenId, poolAddress));
        return uint256(h) < type(uint256).max / (1 + BitMath.mostSignificantBit(tokenId) * 2);
    }
}
