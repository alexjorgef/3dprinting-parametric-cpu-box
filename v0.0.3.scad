$fn=100;

CPU_LENGTH_SOCKET = 50;
CPU_WIDTH_SOCKET = 50;
CPU_EXTRA_GAP = 0.30;
CPU_LENGTH = CPU_LENGTH_SOCKET + CPU_EXTRA_GAP; // X
CPU_WIDTH = CPU_WIDTH_SOCKET + CPU_EXTRA_GAP; // Y
CPU_HEIGHT = 5; // Z
CPU_ADDITIONAL_HEIGHT = 3;
BASE_HEIGHT = 2;
WALL_SIDE_HEIGHT = 2;
WALL_BACK_HEIGHT = 2.5;
WALL_PICK_LENGTH = (CPU_LENGTH/2)+1;
WALL_PICK_HEIGHT = 1.5;
NUM_CILIDENRS_CUT = 3;

BOX_WALL_HEIGHT = WALL_BACK_HEIGHT;
BOX_WALL_EXTRA_GAP = 0.30;

cpu_total_length = CPU_LENGTH + (2 * WALL_SIDE_HEIGHT);
cpu_total_width = CPU_WIDTH + (WALL_SIDE_HEIGHT + WALL_BACK_HEIGHT);
cpu_height = CPU_HEIGHT + CPU_ADDITIONAL_HEIGHT;

// Box
difference() {
    cube([cpu_total_length, cpu_total_width, cpu_height]);
    // Cube cut that give the box form
    translate([WALL_SIDE_HEIGHT, WALL_SIDE_HEIGHT, BASE_HEIGHT]){
        cube([CPU_LENGTH, CPU_WIDTH, 40]);
    }
    // Cilinder cut on side to better grip
    translate([0, CPU_WIDTH/2, CPU_HEIGHT+BASE_HEIGHT+10]){
        rotate([90, 0, 90]){
            cylinder(cpu_total_length, 13, 13);
        }
    }
    // Cilinder cuts on back
    for ( i = [0 : NUM_CILIDENRS_CUT - 1] ){
        translate([(CPU_LENGTH/NUM_CILIDENRS_CUT*i) + (CPU_LENGTH/NUM_CILIDENRS_CUT/2), cpu_total_width, (CPU_HEIGHT + CPU_ADDITIONAL_HEIGHT) / 2]){
            rotate([90, 0, 0]){
                cylinder(WALL_BACK_HEIGHT/2, 3, 3);
            }
        }
    }
}
// Box Tap
translate([(cpu_total_length - WALL_PICK_LENGTH) / 2, 0, CPU_HEIGHT + CPU_ADDITIONAL_HEIGHT]){
    cube([WALL_PICK_LENGTH , WALL_SIDE_HEIGHT, WALL_BACK_HEIGHT]);
}

// ---

UI_TEMP_MOVE = 100;

box_total_length = cpu_total_length + (2 * BOX_WALL_HEIGHT);
box_total_width = cpu_total_width + (2 * BOX_WALL_HEIGHT);
box_total_height = cpu_height + (2 * BOX_WALL_HEIGHT);

// Box Enclosure
translate([-WALL_BACK_HEIGHT, UI_TEMP_MOVE, -WALL_BACK_HEIGHT]){
    difference() {
        cube([box_total_length, box_total_width, box_total_height]);
        // Cube cut to give the box enclosure the form
        translate([
            WALL_SIDE_HEIGHT + BOX_WALL_EXTRA_GAP,
            0, 
            BOX_WALL_HEIGHT - BOX_WALL_EXTRA_GAP
        ]){
            cube([
                cpu_total_length + (2 * BOX_WALL_EXTRA_GAP),
                cpu_total_width,
                cpu_height + (2 * BOX_WALL_EXTRA_GAP)
            ]);
        }
        // Cilinder cut in top middle of enclosure
        translate([
            box_total_length/2,
            box_total_width/2, 
            BOX_WALL_HEIGHT + cpu_height
        ]){
            cylinder(BOX_WALL_HEIGHT, 15, 15);
        }
        // Cube cut for box tap
        BOX_ENCLOSURE_BOX_TAP_TRANSLATE_X = (box_total_length / 2) - ((WALL_PICK_LENGTH + (BOX_WALL_EXTRA_GAP*2)) / 2);
        BOX_ENCLOSURE_BOX_TAP_TRANSLATE_Y = 0;
        BOX_ENCLOSURE_BOX_TAP_TRANSLATE_Z = BOX_WALL_HEIGHT + cpu_height;
        BOX_ENCLOSURE_BOX_TAP_CUBE_LENGTH = (WALL_PICK_LENGTH + (BOX_WALL_EXTRA_GAP*2));
        BOX_ENCLOSURE_BOX_TAP_CUBE_WIDTH = WALL_SIDE_HEIGHT +BOX_WALL_EXTRA_GAP;
        BOX_ENCLOSURE_BOX_TAP_CUBE_HEIGHT = BOX_WALL_HEIGHT;
        translate([
            BOX_ENCLOSURE_BOX_TAP_TRANSLATE_X, 
            BOX_ENCLOSURE_BOX_TAP_TRANSLATE_Y, 
            BOX_ENCLOSURE_BOX_TAP_TRANSLATE_Z
        ]){
            cube([
                BOX_ENCLOSURE_BOX_TAP_CUBE_LENGTH, 
                BOX_ENCLOSURE_BOX_TAP_CUBE_WIDTH, 
                BOX_ENCLOSURE_BOX_TAP_CUBE_HEIGHT
            ]);
        }
    }
}