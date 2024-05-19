<?php

$finder = PhpCsFixer\Finder::create()
  ->in(__DIR__);

return (new PhpCsFixer\Config())
  ->setFinder($finder)
  ->setRules([
    '@PSR12' => true,
    'indentation_type' => true,
  ])
  ->setIndent('  ') // Set 2 spaces as indentation
  ->setLineEnding("\n");
