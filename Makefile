KEYBOARD := planck
KEYMAP := thor

HERE := $(realpath ./)
CODE_DIR := $(realpath ../)
QMK_DIR := $(CODE_DIR)/qmk_firmware
KEYMAP_DIR := $(QMK_DIR)/keyboards/$(KEYBOARD)/keymaps/$(KEYMAP)

$(KEYMAP_DIR):
	mkdir -p $(KEYMAP_DIR)

prepare: | $(KEYMAP_DIR)
	ln -sf $(HERE)/planck_keymap.c $(KEYMAP_DIR)/keymap.c
	ln -sf $(HERE)/planck_rules.mk $(KEYMAP_DIR)/rules.mk
	ln -sf $(HERE)/planck_config.h $(KEYMAP_DIR)/config.h

build: | prepare
	cd $(QMK_DIR) && CFLAGS=-Wno-attribute-alias make $(KEYBOARD):$(KEYMAP)

flash: | prepare
	cd $(QMK_DIR) && CFLAGS=-Wno-attribute-alias make $(KEYBOARD):$(KEYMAP):dfu

update: 
	cd $(KEYMAP_DIR) && git pull --ff-only

clean:
	cd $(QMK_DIR) && make clean

