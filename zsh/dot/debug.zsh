function ${DOT_PREFIX}.debug.on() {
    ${DOT_PREFIX}.config.set log.debug.enabled true
    ${DOT_PREFIX}.config.set log.info.enabled true
    ${DOT_PREFIX}.config.set log.verbose.enabled true
}

function ${DOT_PREFIX}.debug.debug() {
    ${DOT_PREFIX}.config.set log.debug.enabled true
}

function ${DOT_PREFIX}.debug.info() {
    ${DOT_PREFIX}.config.set log.info.enabled true
}

function ${DOT_PREFIX}.debug.verbose() {
    ${DOT_PREFIX}.config.set log.verbose.enabled true
}

function ${DOT_PREFIX}.debug.off() {
    ${DOT_PREFIX}.config.set log.debug.enabled false
    ${DOT_PREFIX}.config.set log.info.enabled false
    ${DOT_PREFIX}.config.set log.verbose.enabled false
}