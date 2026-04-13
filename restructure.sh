#!/bin/bash
# =============================================================================
# CPPNotes Repo Restructuring Script
# =============================================================================
# Run from the root of the CPPNotes repo.
#
# What this does:
#   1. Creates topic subdirectories
#   2. Moves files into the appropriate directories
#   3. Renames inconsistently named files to a uniform convention
#
# IMPORTANT: Obsidian resolves [[wikilinks]] by filename regardless of folder,
# so moving files into subdirectories will NOT break existing wikilinks.
# However, any RENAMES will require updating wikilinks in referring files.
#
# Recommendation: run this, then do a global find-and-replace for renamed files.
# =============================================================================

set -euo pipefail

echo "=== CPPNotes Restructuring ==="
echo ""

# --- Step 1: Create directories ---
echo "Creating directories..."
mkdir -p classes
mkdir -p stl-containers
mkdir -p smart-pointers
mkdir -p value-categories
mkdir -p lambdas-callables
mkdir -p type-system
mkdir -p language-fundamentals
mkdir -p design-idioms

# --- Step 2: Move files into directories ---
echo "Moving files..."

# Classes (move all CLASSES-*.md)
for f in CLASSES-*.md; do
    [ -f "$f" ] && git mv "$f" classes/
done

# STL containers
for f in STD-*.md STL-Cheatsheet.md; do
    [ -f "$f" ] && git mv "$f" stl-containers/
done

# Smart pointers
for f in UniqPtr.md sharedPtr.md weakPtr.md; do
    [ -f "$f" ] && git mv "$f" smart-pointers/
done

# Value categories & move semantics
for f in "L-VALUE R-VALUE.md" l-value-r-value-detail.md move.md; do
    [ -f "$f" ] && git mv "$f" value-categories/
done

# Lambdas & callables
for f in Lambdas1.md Lambdas2.md Lambdas3.md FunctionPointers.md Functors.md; do
    [ -f "$f" ] && git mv "$f" lambdas-callables/
done

# Type system & casting
for f in StaticVsDynamicCast.md ReinterpretCast.md variant.md unions.md; do
    [ -f "$f" ] && git mv "$f" type-system/
done

# Language fundamentals
for f in loops.md references.md static.md mutable.md this.md using.md ArrayDecaytoPointer.md; do
    [ -f "$f" ] && git mv "$f" language-fundamentals/
done

# Design & idioms
for f in API-Design.md RAII.md; do
    [ -f "$f" ] && git mv "$f" design-idioms/
done

# --- Step 3: Rename inconsistent files ---
echo ""
echo "Renaming files for consistency..."

# CLASSES-14.md has no topic description
cd classes
[ -f "CLASSES-14.md" ] && git mv "CLASSES-14.md" "CLASSES-14-AccessModifiersInheritance.md"

# Fix typo: "Inhertence" -> "Inheritance"  
[ -f "CLASSES-20-MultipleInhertence.md" ] && git mv "CLASSES-20-MultipleInhertence.md" "CLASSES-20-MultipleInheritance.md"
cd ..

echo ""
echo "=== Done ==="
echo ""
echo "Remaining manual steps:"
echo "  1. Update wikilinks for renamed files:"
echo "     - [[CLASSES-14]]           -> [[CLASSES-14-AccessModifiersInheritance]]"
echo "     - [[CLASSES-20-MultipleInhertence]] -> [[CLASSES-20-MultipleInheritance]]"
echo "  2. Review the new README.md, Classes.md, and CPP.md"
echo "  3. Commit: git add -A && git commit -m 'Restructure: directories, renames, README'"
