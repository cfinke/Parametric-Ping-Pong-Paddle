handle_length = 100;
handle_style = "straight"; // flared, anatomic, rounded, square, flat, donic, conic 
handle_thickness = 25;
handle_width = 35;
handle_offset = 0;

blade_width = 150;
blade_length = 160;
blade_thickness = 6;
blade_shape = "pear"; // oval, pear, square

$fs = 1;
$fa = 1;

module paddle() {
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
    translate([0, -(blade_length / 2) - handle_offset + blade_thickness, 0]) rotate([90, 0, 0]) rotate([0, 0, 90]) {
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

paddle();