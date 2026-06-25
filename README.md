<div align="center">

# 🧠 SecondMind.ai

### Your AI Chief of Staff — Connected to Your Conversations

[![Live Preview](https://img.shields.io/badge/🌐_Live_Preview-Visit_App-00d992?style=for-the-badge)](https://second-mind-ai.vercel.app/)
[![Next.js](https://img.shields.io/badge/Next.js-15-black?style=flat-square&logo=next.js)](https://nextjs.org/)
[![TypeScript](https://img.shields.io/badge/TypeScript-5-3178C6?style=flat-square&logo=typescript&logoColor=white)](https://typescriptlang.org/)
[![Tailwind CSS](https://img.shields.io/badge/Tailwind_CSS-3.4-06B6D4?style=flat-square&logo=tailwindcss&logoColor=white)](https://tailwindcss.com/)
[![InsForge](https://img.shields.io/badge/InsForge-BaaS-6366f1?style=flat-square)](https://insforge.dev/)

Unify your WhatsApp, Telegram, Gmail, and Outlook into a secure cognitive intelligence workspace.  
Get automated digests, context-aware drafts, calendar conflict resolutions, and smart reminders — instantly.

</div>

---

> [!WARNING]
> **🚧 Active Development — Beta Testing Phase**
>
> SecondMind.ai is currently **under active testing**. While the core experience is functional, please be aware of the following:
>
> - Some features are **not fully operational** and may behave unexpectedly.
> - Integrations (WhatsApp, Slack, Discord, LinkedIn, Outlook Calendar) are in **preview mode** and may not persist sessions reliably.
> - Background jobs (Trigger.dev schedules) require separate deployment configuration.
> - Phone authentication uses an **in-memory OTP store** — not suitable for production.
> - AI-generated responses depend on the `GEMINI_API_KEY`; without it, the app falls back to **simulated previews**.
>
> We appreciate your patience and feedback as we work toward a stable release. If you encounter issues, please [open an issue](https://github.com/abhnvkanth/SecondMind.ai/issues).

---

## 🌐 Live Preview

**Experience SecondMind.ai live:**

<div align="center">

### 👉 [https://second-mind-ai.vercel.app/](https://second-mind-ai.vercel.app/)

</div>

> [!NOTE]
> The live preview is a hosted demo environment. Some backend-dependent features (real-time integrations, background job execution, OTP verification) may be limited in the demo. Sign in to explore the full dashboard experience.

---

## 📸 App Screenshots

<details>
<summary><strong>🏠 Landing Page</strong> — First impression & product overview</summary>
<br/>

![Landing Page](docs/screenshots/landing-page.png)

The landing page introduces SecondMind's core value proposition with an interactive demo, feature highlights, pricing tiers, and platform statistics.

</details>

<details>
<summary><strong>📊 Dashboard</strong> — Your cognitive command center</summary>
<br/>

![Dashboard](docs/screenshots/dashboard.png)

The main dashboard surfaces today's brief, connected apps status, priority items, and key metrics — all powered by the Cognitive Live Sync Engine.

</details>

<details>
<summary><strong>🤖 AI Agent</strong> — Intelligent conversational assistant</summary>
<br/>

![AI Agent](docs/screenshots/ai-agent.png)

The AI Agent analyzes activity across connected platforms (Gmail, WhatsApp, LinkedIn), performs task & urgency analysis, and suggests actionable follow-ups.

</details>

<details>
<summary><strong>🔔 Alerts</strong> — Real-time monitoring & notifications</summary>
<br/>

![Alerts](docs/screenshots/alerts.png)

The Alerts dashboard tracks active alerts, trigger history, priority levels, and AI-suggested alerts generated from connected app activity.

</details>

<details>
<summary><strong>🔗 Integrations</strong> — Connect your communication channels</summary>
<br/>

![Integrations](docs/screenshots/integrations.png)

Bridge your communication channels — Gmail, WhatsApp, Slack, Discord, LinkedIn, and Outlook Calendar — into SecondMind's background processing model.

</details>

---

## ✨ Key Features

| Feature | Description | Status |
|---------|-------------|--------|
| **AI Agent Chat** | Context-aware assistant powered by Gemini with connected app data | ✅ Live |
| **Smart Dashboard** | Unified command center with briefs, priorities & metrics | ✅ Live |
| **Gmail Integration** | OAuth-based inbox access, search, and draft composition | ✅ Live |
| **Automated Briefings** | Scheduled AI-generated communication summaries | ✅ Live |
| **Alert System** | Rule-based monitoring with AI-suggested alerts | ✅ Live |
| **WhatsApp Sync** | Message history sync and session management | 🧪 Beta |
| **Slack Integration** | Workspace history and channel notifications | 🧪 Beta |
| **Discord Integration** | Channel monitoring and community management | 🔜 Coming Soon |
| **LinkedIn Integration** | Feed updates and profile management | 🔜 Coming Soon |
| **Outlook Calendar** | Calendar analysis and event scheduling | 🔜 Coming Soon |
| **Phone Auth (OTP)** | SMS-based authentication via Sent.dm | ⚠️ Dev Only |

---

## 🛠 Tech Stack

- **Framework:** Next.js App Router (v15)
- **Language:** TypeScript
- **UI:** React, Tailwind CSS 3.4, Lucide Icons, Hugeicons
- **Backend:** InsForge (PostgreSQL, Auth, Realtime, Storage)
- **AI:** Google Gemini via `@google/genai`
- **Background Jobs:** Trigger.dev schedules and tasks
- **Messaging:** Gmail OAuth, WhatsApp session helpers, Sent.dm OTP delivery

---

## 📁 Project Structure

```text
app/
  page.tsx                         Landing page and interactive product demo.
  layout.tsx                       Root providers, fonts, metadata, and theme bootstrap.
  dashboard/
    layout.tsx                     Authenticated dashboard shell and sidebar navigation.
    page.tsx                       Main dashboard tabs, panels, AI agent, integrations, alerts, and settings.
    briefing/[id]/page.tsx         Detail view for a generated briefing.
  auth/
    callback/page.tsx              InsForge auth redirect handler.
    gmail-callback/page.tsx        Google OAuth callback handoff.
  api/
    ai-chat/route.ts               AI assistant endpoint using synced Gmail/WhatsApp context.
    dashboard-brief/route.ts       Dashboard intelligence brief generation and caching.
    briefings/*                    Briefing CRUD, schedules, and AI draft routes.
    alerts/*                       Alert list, rules, suggestions, actions, and AI helper routes.
    gmail-*                        Gmail OAuth and Gmail data proxy routes.
    whatsapp-*                     WhatsApp connect/status/data proxy routes.
    phone-auth/*                   OTP send and verify routes.
components/
  auth-provider.tsx                Client auth context and user profile synchronization.
  theme-provider.tsx               Light/dark theme state.
lib/
  insforge.ts                      Shared public InsForge SDK client.
  insforge-admin.ts                Server-side admin client fallback helper.
  alert-auto-generation.ts         Fetches connected activity and turns it into alerts.
  alerts-realtime.ts               Publishes alert events over InsForge realtime.
  whatsapp.ts                      WhatsApp connection/session logic.
  otp-store.ts                     In-memory OTP store for local verification.
trigger/
  alerts.ts                        Scheduled alert checks and alert creation jobs.
  briefing.ts                      Scheduled briefing generation jobs.
db/
  alerts.sql                       Alert schema and database setup SQL.
```

---

## 🚀 Getting Started

### Prerequisites

- Node.js 18+ and npm
- An [InsForge](https://insforge.dev) project with database tables configured
- A [Google Cloud](https://console.cloud.google.com) project with Gmail API OAuth credentials
- A [Gemini API key](https://aistudio.google.com/apikey) for AI features

### Installation

1. **Clone the repository:**

```bash
git clone https://github.com/abhnvkanth/SecondMind.ai.git
cd SecondMind.ai
```

2. **Install dependencies:**

```bash
npm install
```

3. **Configure environment variables:**

Create `.env.local` in the project root:

```bash
NEXT_PUBLIC_APP_URL=http://localhost:3000
APP_URL=http://localhost:3000

NEXT_PUBLIC_INSFORGE_URL=https://3ewxfrr2.us-east.insforge.app
NEXT_PUBLIC_INSFORGE_ANON_KEY=your_insforge_anon_key
INSFORGE_API_KEY=your_insforge_admin_or_api_key

GEMINI_API_KEY=your_gemini_api_key

GOOGLE_CLIENT_ID=your_google_oauth_client_id
GOOGLE_CLIENT_SECRET=your_google_oauth_client_secret

SENT_DM_API_KEY=your_sentdm_api_key
SENT_DM_TEMPLATE_ID=your_sentdm_template_id
```

4. **Configure Google OAuth:**

   - Add `http://localhost:3000/auth/gmail-callback` as an authorized redirect URI.
   - Use the same `GOOGLE_CLIENT_ID` and `GOOGLE_CLIENT_SECRET` in `.env.local`.

5. **Prepare the database:**

   - Apply the SQL in `db/alerts.sql` to the InsForge project.
   - Ensure the `users`, `alerts`, `alert_rules`, `briefing_schedules`, and `generated_briefings` tables exist.
   - Keep secrets in `.env.local` and InsForge project config; do not hardcode private keys.

6. **Start the development server:**

```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) to view the app.

---

## 📜 Available Scripts

| Command | Description |
|---------|-------------|
| `npm run dev` | Start local development server |
| `npm run build` | Create production build |
| `npm run start` | Start production server after build |
| `npm run lint` | Run ESLint |

---

## ⚙️ How It Works

### Authentication
Authentication starts in `components/auth-provider.tsx`. It checks for a local phone-auth user first, then falls back to InsForge auth. When a user signs in, the provider creates or updates the matching `users` row so dashboard data and integrations stay attached to one user ID.

### Dashboard
The dashboard in `app/dashboard/page.tsx` reads the active tab from the `tab` query parameter. Each panel handles one workflow: overview, AI agent, briefing, inbox/follow-ups, integrations, alerts, settings, or pricing.

### AI Chat
AI chat uses `app/api/ai-chat/route.ts`. The route validates the user, reads integration metadata from InsForge, fetches recent Gmail/WhatsApp context when connected, and sends that context to Gemini. If `GEMINI_API_KEY` is missing, it returns a simulated response instead of breaking the UI.

### Dashboard Briefs
Dashboard briefs use `app/api/dashboard-brief/route.ts`. Briefs are cached in the `users.dashboard_brief` field for two hours unless the request asks to regenerate. With connected app data and a Gemini key, the route creates a real summary. Otherwise it saves a simulated preview.

### Alert System
Alerts use `lib/alert-auto-generation.ts`, `app/api/alerts/*`, and `trigger/alerts.ts`. The background job checks active alert rules, fetches connected app activity, deduplicates alerts with a `dedupe_key`, saves new alerts, and publishes realtime updates through InsForge.

### Scheduled Briefings
Scheduled briefings use `trigger/briefing.ts`. The cron task finds due briefing schedules, advances `next_run_at`, fetches connected communication data, generates a Gemini briefing when possible, and stores the result in `generated_briefings`.

### Phone Auth
Phone auth uses `app/api/phone-auth/send-otp/route.ts`, `app/api/phone-auth/verify-otp/route.ts`, and `lib/otp-store.ts`. OTPs are stored in memory for local development and consumed after one successful verification.

> [!IMPORTANT]
> For production, replace the in-memory OTP store with Redis or a database-backed TTL table.

---

## 🔒 Environment Notes

- `NEXT_PUBLIC_*` variables are available in browser code. Do not put private secrets in them.
- `INSFORGE_API_KEY` is required for server workflows that need to bypass row-level security, such as background alert generation.
- `GEMINI_API_KEY` enables real AI summaries and assistant responses.
- `APP_URL` should point to the deployed app URL in production so Trigger.dev jobs can call local API routes correctly.
- The public InsForge anon key can be used by client code, but admin/API keys must stay server-side only.

---

## 👨‍💻 Development Workflow

1. Make the smallest focused code change.
2. Keep InsForge database writes associated with the authenticated `userId`.
3. Run `npm run lint` before committing.
4. Run `npm run build` when changing routes, server code, or shared types.
5. Test the main dashboard flows manually: sign in, connect integrations, generate a brief, ask the AI agent, and create or resolve an alert.

---

## 🚢 Production Checklist

- [ ] Replace local callback URLs with deployed URLs in Google OAuth settings.
- [ ] Set production values for every required environment variable.
- [ ] Use a durable OTP store instead of the module-level `Map`.
- [ ] Confirm InsForge RLS policies allow intended user-owned reads/writes only.
- [ ] Configure Trigger.dev deployment and schedules.
- [ ] Verify that `APP_URL` and `NEXT_PUBLIC_APP_URL` match the deployed domain.

---

<div align="center">

**Built with ❤️ by [Abhinav Kanth](https://github.com/abhnvkanth)**

[![Live Demo](https://img.shields.io/badge/Try_It_Live-second--mind--ai.vercel.app-00d992?style=for-the-badge)](https://second-mind-ai.vercel.app/)

</div>

