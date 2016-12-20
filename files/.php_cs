<?php

return PhpCsFixer\Config::create()
    ->setRiskyAllowed(true)
    ->setUsingCache(false)
    ->setRules([
        '@Symfony'     => true,
        'array_syntax' => [
            'syntax' => 'short',
        ],
        'binary_operator_spaces' => [
            'align_equals'       => true,
            'align_double_arrow' => true,
        ],
        'combine_consecutive_unsets'                => true,
        'dir_constant'                              => true,
        'linebreak_after_opening_tag'               => true,
        'modernize_types_casting'                   => true,
        'no_multiline_whitespace_before_semicolons' => true,
        'no_short_echo_tag'                         => true,
        'no_useless_else'                           => true,
        'no_useless_return'                         => true,
        'ordered_imports'                           => true,
        'phpdoc_add_missing_param_annotation'       => [
            'only_untyped' => false,
        ],
        'phpdoc_order'                => true,
        //'semicolon_after_instruction' => true,
        'simplified_null_return'      => true,
    ]);
