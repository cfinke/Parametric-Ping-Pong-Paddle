// The length of the handle from where it meets the surface of the blade.
handle_length = 100;

// The handle style.
handle_style = "straight"; // [straight, flared, anatomic, rounded, square, flat, donic, conic]

// The thickness of the handle, top to bottom when the blade is facing up/down.
handle_thickness = 25;

// The width of the handle, measured left to right when the blade is facing up/down.
handle_width = 35;

// The distance the handle should be offset from the usual position where it meets the blade. A higher number makes the handle effectively shorter.
handle_offset = 0;

// The width of the blade at its widest point.
blade_width = 150;

// The length of the blade at its longest point.
blade_length = 160;

// The thickness of the blade.
blade_thickness = 6;

// The blade shape.
blade_shape = "pear"; // [oval, pear, square, oblong]

$fs = 1;
$fa = 1;

module paddle(handle_length=100, handle_style="straight", handle_thickness=25, handle_width=35, handle_offset=0, blade_width=150, blade_length=160, blade_thickness=6, blade_shape="pear") {
    // Blade
    translate([0, 0, -blade_thickness / 2]) linear_extrude(blade_thickness) {
        if ( "oval" == blade_shape ) {
            scale([1, blade_length / blade_width, 1]) circle(r=blade_width/2);
        }
        else if ( "pear" == blade_shape ) {
            hull() {
                offset = blade_length - ( blade_width / 2 ) - ( blade_width / 2.2 );
                
                translate([0, -offset / 2, 0]) {
                    translate([0, offset, 0]) circle(r=blade_width / 2.2 );
                    circle(r=blade_width / 2);
                }
            }
        }
        else if ( "square" == blade_shape ) {
            square([blade_width, blade_length], true);
        }
    }
    
    // Handle
    translate([0, -(blade_length / 2) + handle_offset + blade_thickness, 0]) rotate([90, 0, 0]) rotate([0, 0, 90]) {
        intersection() {
            union() {
                if ( "straight" == handle_style ) {
                    linear_extrude(handle_length) scale([1, handle_width / handle_thickness, 1]) circle(r=handle_thickness/2);
                }
            }
            
            vertical_offset = sqrt( 2 * pow(handle_length / 2, 2)) - ( blade_thickness / 2 );
            
            translate([0, 0, vertical_offset]) rotate([0, 45, 0]) cube([handle_length, handle_length, handle_length], true); 
        }
    }
}

paddle(handle_length=handle_length, handle_style=handle_style, handle_thickness=handle_thickness, handle_width=handle_width, handle_offset=handle_offset, blade_width=blade_width, blade_length=blade_length, blade_thickness=blade_thickness, blade_shape=blade_shape);
