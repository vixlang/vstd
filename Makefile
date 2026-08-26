VIXC := /home/zty/Vix-lang/build/vixc
BUILD_DIR := build

OFFLINE_TESTS := test_collections test_json test_json_parse test_mem test_runtime test_str test_vlibtui_render
OWNERSHIP_TESTS := $(OFFLINE_TESTS) test_http test_vcurl test_vcurl_deepseek vcurl
CURL_TESTS := test_vcurl test_vcurl_deepseek vcurl

.PHONY: test ownership-check clean

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

clean:
	rm -rf $(BUILD_DIR)
