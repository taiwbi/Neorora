<?php

return (new PhpCsFixer\Config())
  ->setRules([
    '@Symfony' => true,
    'indentation_type' => true,
  ])
  ->setIndent('  ')
  ->setLineEnding("\n");
