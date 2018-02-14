// [ARMIPS 0.9+] Moon-Jump Example by Davideesk

// When the player holds the L button, Mario will float up into the air

.defineLabel MARIO_STRUCT, 0x8033B170

// See this wiki page for a list of Mario's actions: http://wiki.origami64.net/sm64:actions
.defineLabel ACTION_DIVE, 0x0188088A 
.defineLabel ACTION_DSLIDE, 0x00880456

.orga 0x861C0 ; Set ROM address, we are overwritting a useless loop function as our hook.
.area 0xA4 ; Set data import limit to 0xA4 bytes
addiu sp, sp, -0x18
sw ra, 0x14 (sp)

// Tests if the player pressed L on this frame
.f_testInput BUTTON_B, BUTTON_PRESSED, proc802CB1C0_end
nop

li t0, MARIO_STRUCT
li t1, ACTION_DIVE
li t2, ACTION_DSLIDE
lw t3, 0x0C(t0) ; get mario's current action

bne t3, t2, proc802CB1C0_end
nop

sw t1, 0x0C(t0) ; Set mario's action to diving.
li t1, 30.0
mtc1 t1, f2
swc1 f2, 0x4C(t0) ; Set mario's y-speed to be 30.0

proc802CB1C0_end:
lw ra, 0x14 (sp)
jr ra
addiu sp, sp, 0x18
.endarea
