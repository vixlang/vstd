VIXC := /home/zty/Vix-lang/build/vixc
BUILD_DIR := build

OFFLINE_TESTS := test_collections test_json test_json_parse test_mem test_runtime test_str test_tinyui test_vlibtui_render
OWNERSHIP_TESTS := $(OFFLINE_TESTS) test_http test_vcurl test_vcurl_deepseek vcurl
CURL_TESTS := test_vcurl test_vcurl_deepseek vcurl
GTK_LIBS := $(shell pkg-config --libs-only-l gtk+-3.0 2>/dev/null)

.PHONY: test ownership-check gtk-check gtk-build editor-build clean

test:
	@mkdir -p $(BUILD_DIR)
	@set -e; for name in $(OFFLINE_TESTS); do \
		$(VIXC) tests/$$name.vix -o $(BUILD_DIR)/$$name; \
		$(BUILD_DIR)/$$name; \
	done

ownership-check:
	@mkdir -p $(BUILD_DIR)
	@set -e; for name in $(OWNERSHIP_TESTS); do \
		extra=""; \
		case " $(CURL_TESTS) " in *" $$name "*) extra="-lcurl";; esac; \
		$(VIXC) --ownership-check tests/$$name.vix $$extra -o $(BUILD_DIR)/$${name}_ownership; \
	 done

gtk-check:
	@test -n "$(GTK_LIBS)" || (echo "GTK3 development files not found"; exit 1)
	$(VIXC) --check examples/tinyui_gtk_demo.vix

gtk-build:
	@test -n "$(GTK_LIBS)" || (echo "GTK3 development files not found"; exit 1)
	@mkdir -p $(BUILD_DIR)
	$(VIXC) examples/tinyui_gtk_demo.vix $(GTK_LIBS) -o $(BUILD_DIR)/tinyui_gtk_demo

editor-build:
	@test -n "$(GTK_LIBS)" || (echo "GTK3 development files not found"; exit 1)
	@mkdir -p $(BUILD_DIR)
	$(VIXC) examples/vix_editor.vix $(GTK_LIBS) -o $(BUILD_DIR)/vix_editor

clean:
	rm -rf $(BUILD_DIR)
