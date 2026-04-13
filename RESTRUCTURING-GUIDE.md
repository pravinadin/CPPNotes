# CPPNotes — Restructuring Guide

## Overview of Changes

This guide covers three categories of fixes:
1. **New files** — README.md, updated CPP.md, updated Classes.md
2. **Directory reorganization** — grouping 72 flat files into 8 topic folders
3. **File renames** — fixing inconsistencies and missing descriptions

---

## 1. New / Replaced Files

| File | Action | Purpose |
|------|--------|---------|
| `README.md` | **New** | Full table of contents with GitHub-compatible links, reading order, and repo description |
| `CPP.md` | **Replace** | Was 4 wikilinks; now comprehensive master index covering all 72 notes |
| `Classes.md` | **Replace** | Was 10 entries with broken links; now all 30 entries with correct filenames |

---

## 2. Directory Structure

```
CPPNotes/
├── README.md
├── CPP.md                          (master index — Obsidian)
├── Classes.md                      (classes sub-index — Obsidian)
│
├── classes/                        (30 files)
│   ├── CLASSES-1 (Introduction to C++ class).md
│   ├── CLASSES-2 ( Default Constructor, default destructor).md
│   ├── ...through CLASSES-33...
│
├── stl-containers/                 (22 files)
│   ├── STL-Cheatsheet.md
│   ├── STD-vector.md
│   ├── STD-map.md
│   ├── ...etc...
│
├── smart-pointers/                 (3 files)
│   ├── UniqPtr.md
│   ├── sharedPtr.md
│   └── weakPtr.md
│
├── value-categories/               (3 files)
│   ├── L-VALUE R-VALUE.md
│   ├── l-value-r-value-detail.md
│   └── move.md
│
├── lambdas-callables/              (5 files)
│   ├── Lambdas1.md ... Lambdas3.md
│   ├── FunctionPointers.md
│   └── Functors.md
│
├── type-system/                    (4 files)
│   ├── StaticVsDynamicCast.md
│   ├── ReinterpretCast.md
│   ├── variant.md
│   └── unions.md
│
├── language-fundamentals/          (7 files)
│   ├── loops.md, references.md, static.md
│   ├── mutable.md, this.md, using.md
│   └── ArrayDecaytoPointer.md
│
└── design-idioms/                  (2 files)
    ├── API-Design.md
    └── RAII.md
```

---

## 3. File Renames

Only two files need actual renaming (beyond the directory moves):

| Old Name | New Name | Reason |
|----------|----------|--------|
| `CLASSES-14.md` | `CLASSES-14-AccessModifiersInheritance.md` | No topic in filename; content is about access modifiers in inheritance |
| `CLASSES-20-MultipleInhertence.md` | `CLASSES-20-MultipleInheritance.md` | Typo: "Inhertence" → "Inheritance" |

### Wikilink Updates Required After Renames

Search across all `.md` files and replace:

```
[[CLASSES-14]]  →  [[CLASSES-14-AccessModifiersInheritance]]
[[CLASSES-20-MultipleInhertence]]  →  [[CLASSES-20-MultipleInheritance]]
```

Files known to reference these (check `Classes.md` and `CPP.md` — the new versions already use the correct names).

---

## 4. Broken Wikilinks in Original Classes.md

The original `Classes.md` had these broken links that did not match any filename:

| Broken Wikilink in Old Classes.md | Should Have Been |
|-----------------------------------|------------------|
| `[[Classes part 10 - Rule of Five - Have fun reducing memory allocations]]` | `[[CLASSES-10-RuleofFive-ReduceMemAllocations]]` |
| `[[Classes part 11 - friend functions]]` | `[[CLASSES-11-FriendFunctions]]` |
| `[[CLASSES12-Explicit ctor and list initialization to avoid conversions]]` | `[[CLASSES-12-ExplicitCtorListInitialization]]` |

All three are fixed in the new `Classes.md`.

---

## 5. Missing Numbers in the CLASSES Series

The following numbers have no corresponding file:

| Missing # | Likely Topic (based on surrounding context) |
|-----------|---------------------------------------------|
| 9 | Between Structs (8) and Rule of Five (10) — possibly move semantics intro? |
| 25 | Between Multiple Inheritance Revisited (24) and Value Initialization (26) |
| 31 | Between pImpl (30) and Static Members (32) |

These can be filled in later or the series can be renumbered. The README notes the gaps.

---

## 6. Optional Future Improvements

These aren't blocking but would improve the repo over time:

- **Normalize all CLASSES filenames** to a consistent pattern like `CLASSES-NN-TopicName.md` (remove parentheses, spaces-in-parens style from 1–5).
- **Add `[[STL-Cheatsheet]]` backlinks** to each `STD-*.md` file so readers can navigate from a container deep-dive back to the overview.
- **Clean up transcript-style notes** — files like CLASSES-14 open with "This video explains..." which reads as raw lecture notes rather than reference material. A light pass to restructure into headings + code would help.
- **Add a `.obsidian/` config** with a graph group config matching the folder structure, so the Obsidian graph view color-codes by topic.
