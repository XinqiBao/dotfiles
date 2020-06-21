def Settings(**kwargs):
    return {'flags': [
        '-I.',
        '-I/usr/include/',
        '-Ilib',
        '-Iinclude',
        '-Iincludes',
        '-I../include',
""" flags for kernel code
        '-I/lib/modules/5.4.46-1-lts/build/arch/x86/include',
        '-I/lib/modules/5.4.46-1-lts/build/arch/x86/include/generated',
        '-I/lib/modules/5.4.46-1-lts/build/arch/x86/include/generated/uapi',
        '-I/lib/modules/5.4.46-1-lts/build/arch/x86/include/uapi',
        '-I/lib/modules/5.4.46-1-lts/build/include',
        '-I/lib/modules/5.4.46-1-lts/build/include/generated/uapi',
        '-I/lib/modules/5.4.46-1-lts/build/include/uapi',
        '-include/lib/modules/5.4.46-1-lts/build/include/linux/kconfig.h',
        '-D__KERNEL__',
        '-DMODULE',
        '-DCONFIG_64BIT',
        '-DCONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES',
        '-DCONFIG_TREE_RCU',
        '-DCONFIG_HZ=100',
        '-DCONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK',
"""
        ]}
