# GitHub Concepts Mapped to felixOrg Stack

## 1. Repositories → **Concrete Assets**

**Rule:** *One repo = one coherent artifact.*

### What counts as a separate repo for you

* **Zarkov Core**

  * Broker logic
  * Routing rules
  * Model adapters
* **Watson Prompts & Policies**

  * System prompts
  * Governance rules
  * Safety constraints
* **felixOrg Handbook**

  * Markdown
  * Diagrams
  * Generated PDFs
* **Experimental Sandboxes**

  * CALM research
  * Vector store benchmarks
  * LLM evaluation harnesses

**Smell test:**
If it can be versioned, tested, and broken independently → it’s its own repo.

**Bad idea (don’t do this):**

* One mega-repo with “everything Watson”
* Repos named after dates or phases
* Mixing experiments with canonical docs

---

## 2. Projects → **Intent & Control**

**Rule:** *Projects express “why” and “when,” not “how.”*

### What GitHub Projects should track for you

* **Zarkov MVP**

  * Routing stability
  * Local vs cloud arbitration
* **Local LLM Evaluation**

  * CALM vs transformer tests
  * Accuracy vs latency
* **Knowledge Ingestion**

  * DEVONthink sync
  * Calibre metadata normalization
* **Governance & Risk**

  * Privacy boundaries
  * Failure modes
  * Offline survivability

Each Project can span:

* Zarkov repo
* Handbook repo
* Experimental repos

**Key insight:**
Projects are where *decisions* live.
Repos are where *implementations* live.

---

## 3. Packages → **Operational Deliverables**

**Rule:** *Packages are what you can deploy or reuse without thinking.*

### What “packages” mean in your world

Not just public libraries—**internal artifacts count**.

Examples:

* `zarkov-core` Python package
* Docker image for local inference broker
* Prebuilt evaluation dataset bundle
* Versioned prompt packs
* Config schemas

Even if **only you** ever consume them, packaging matters because:

* You redeploy often
* You run multiple machines (RFStudio, RFiMac, VMs)
* You care about reproducibility

**Hard truth:**
If you can’t package it, you can’t trust it later.

---

## The Correct Architecture (textbook clean)

```
┌──────────────────────────┐
│      GitHub Projects     │  ← intent, roadmap, risk
│  (Watson / Zarkov goals) │
└───────────┬──────────────┘
            │
┌───────────▼──────────────┐
│        Repositories       │  ← source, docs, tests
│  zarkov-core               │
│  watson-prompts            │
│  felixOrg-handbook         │
└───────────┬──────────────┘
            │
┌───────────▼──────────────┐
│         Packages          │  ← deployable artifacts
│  Docker / wheels / zips   │
│  prompt bundles           │
└──────────────────────────┘
```

---

## Naming Conventions You Should Actually Use

### Repos

* `zarkov-core`
* `zarkov-eval`
* `watson-governance`
* `felixorg-handbook`

### Projects

* `Zarkov MVP`
* `Local LLM Research`
* `Knowledge Ingestion & RAG`
* `Risk & Privacy Governance`

### Packages

* `zarkov-core`
* `zarkov-router`
* `watson-prompts-base`
* `watson-prompts-finance`

Don’t get cute. Future-you hates cute.

---

## One Strategic Recommendation (pay attention)

**Treat your handbook as a first-class repo, not “docs.”**

That means:

* Versioned releases
* Tagged snapshots
* Generated PDFs as artifacts
* Cross-linked issues

This turns your personal system into something closer to:

> *A living technical standard you happen to own.*

That’s rare—and powerful.

---

## Final reality check

If GitHub disappeared tomorrow:

* **Repos** → you still have Git
* **Packages** → you still have artifacts
* **Projects** → you lose context

So use Projects ruthlessly to capture *why*, not busywork.

If you want, next step:

* I can propose **exact repo boundaries** for your current Watson/Zarkov code
* Or design a **GitHub Projects board schema** that matches how you actually think, not how Atlassian wants you to think
