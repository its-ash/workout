<!-- eslint-disable @stylistic/quotes -->
<template>
  <main class="app-shell">
    <header class="topbar glass">
      <div class="brand-left">
        <h1>Daily Split Tracker</h1>
      </div>
      <button
        v-if="canInstall || canShowInstallHelp"
        class="install-btn install-top-right"
        @click="handleInstallClick"
      >
        {{ canInstall ? "Install App" : "How to Install" }}
      </button>
      <div class="header-actions">
        <div class="badge level-picker">
          <span>Level</span>
          <select v-model="state.level" class="level-select">
            <option v-for="level in levels" :key="level" :value="level">
              {{ level }}
            </option>
          </select>
        </div>
      </div>
    </header>

    <section class="workspace">
      <div class="content-stack">
        <section class="day-card">
          <ul class="workouts">
            <li v-for="item in detailedWorkout" :key="item.name + item.plan">
              <p class="workout-name">{{ item.name }}</p>
              <p class="workout-plan">{{ item.plan }}</p>
              <p class="workout-note">{{ item.note }}</p>
            </li>
          </ul>
        </section>
      </div>
    </section>

    <div class="actions day-actions">
      <button
        v-if="canInstall || canShowInstallHelp"
        class="secondary"
        @click="handleInstallClick"
      >
        {{ canInstall ? "Install App" : "How to Install" }}
      </button>
      <button class="primary" :disabled="isDoneToday" @click="completeDay">
        {{ isDoneToday ? "Completed" : "Complete Day" }}
      </button>
    </div>

    <section v-if="showUpdateBanner" class="update-toast">
      <p class="update-copy">A new version is ready.</p>
      <div class="update-actions">
        <button class="secondary" @click="dismissUpdate">Later</button>
        <button class="primary" @click="applyUpdate">Update Now</button>
      </div>
    </section>

    <section v-if="showInstallHelp" class="update-toast">
      <p class="update-copy">Install App</p>
      <div
        class="workout-note"
        style="margin-top: 0; border-top: 0; padding-top: 0"
      >
        {{ installHelpText }}
      </div>
      <div class="update-actions">
        <button class="secondary" @click="showInstallHelp = false">
          Close
        </button>
      </div>
    </section>
  </main>
</template>

<script setup lang="ts">
import { computed, onMounted, reactive, ref, unref, watch } from "vue";

type SplitDay = { day: number; workout: string[] };
type SplitProgram = { id: string; title: string; days: SplitDay[] };
type LevelName = "Beginner" | "Intermediate" | "Advanced";
type WorkoutState = {
  level: LevelName;
  currentDay: number;
  completedDays: number[];
};
type WorkoutLine = { name: string; plan: string; note: string };

const levels: LevelName[] = ["Beginner", "Intermediate", "Advanced"];
const DAYS_PER_CYCLE = 6;

const pushPullLegsSplit: SplitProgram = {
  id: "push-pull-legs",
  title: "Push / Pull / Legs",
  days: [
    {
      day: 1,
      workout: [
        "Barbell Bench Press - 4 sets x 6 reps, rest 150s",
        "Incline Dumbbell Press - 4 sets x 8 reps, rest 120s",
        "Standing Overhead Press - 3 sets x 8 reps, rest 120s",
        "Cable Lateral Raise - 4 sets x 15 reps, rest 60s",
        "Cable Upright Row - 3 sets x 12 reps, rest 75s",
        "Machine Chest Press - 3 sets x 10 reps, rest 90s",
        "Overhead Cable Triceps Extension - 3 sets x 12 reps, rest 60s",
        "Rope Triceps Pressdown - 3 sets x 12 reps, rest 60s",
      ],
    },
    {
      day: 2,
      workout: [
        "Weighted Pull Up - 4 sets x 6 reps, rest 150s",
        "Chest Supported Row - 4 sets x 8 reps, rest 120s",
        "Neutral Grip Lat Pulldown - 3 sets x 10 reps, rest 90s",
        "Single Arm Cable Row - 3 sets x 12 reps each side, rest 75s",
        "Reverse Pec Deck - 3 sets x 15 reps, rest 60s",
        "Incline Dumbbell Curl - 3 sets x 12 reps, rest 60s",
        "Cable Bayes Curl - 3 sets x 12 reps each arm, rest 60s",
      ],
    },
    {
      day: 3,
      workout: [
        "High Bar Back Squat - 4 sets x 6 reps, rest 180s",
        "Romanian Deadlift - 4 sets x 8 reps, rest 150s",
        "Leg Press (Deep Range) - 3 sets x 12 reps, rest 120s",
        "Seated Leg Curl - 3 sets x 12 reps, rest 90s",
        "Leg Extension - 3 sets x 15 reps, rest 75s",
        "Standing Calf Raise - 4 sets x 12 reps, rest 60s",
        "Dumbbell Lateral Raise - 3 sets x 20 reps, rest 45s",
      ],
    },
    {
      day: 4,
      workout: [
        "Standing Overhead Press - 4 sets x 6 reps, rest 150s",
        "Incline Barbell Press - 4 sets x 8 reps, rest 120s",
        "Machine Chest Press - 3 sets x 10 reps, rest 90s",
        "Cable Lateral Raise - 4 sets x 15 reps, rest 60s",
        "Cable Rear Delt Fly - 3 sets x 15 reps, rest 60s",
        "Weighted Dips - 3 sets x 8 reps, rest 90s",
        "Rope Triceps Pressdown - 3 sets x 12 reps, rest 60s",
        "Overhead Cable Triceps Extension - 3 sets x 12 reps, rest 60s",
      ],
    },
    {
      day: 5,
      workout: [
        "Neutral Grip Lat Pulldown - 4 sets x 8 reps, rest 120s",
        "Barbell Row - 4 sets x 8 reps, rest 120s",
        "Cable Pullover - 3 sets x 12 reps, rest 75s",
        "Rear Delt Cable Fly - 3 sets x 15 reps, rest 60s",
        "Hammer Curl - 3 sets x 10 reps, rest 60s",
        "Preacher Curl - 3 sets x 12 reps, rest 60s",
        "Cable Reverse Curl - 3 sets x 15 reps, rest 60s",
      ],
    },
    {
      day: 6,
      workout: [
        "Front Squat - 4 sets x 6 reps, rest 180s",
        "Barbell Hip Thrust - 4 sets x 8 reps, rest 120s",
        "Bulgarian Split Squat - 3 sets x 10 reps each leg, rest 90s",
        "Leg Extension - 3 sets x 15 reps, rest 75s",
        "Seated Calf Raise - 4 sets x 15 reps, rest 60s",
        "Cable Lateral Raise - 3 sets x 20 reps, rest 45s",
        "Core Finisher - 12 minutes (mountain climber, plank, hollow hold)",
      ],
    },
  ],
};

const STORE_KEY = "workout-pwa-v1";

const state = reactive<WorkoutState>({
  level: levels[0],
  currentDay: 1,
  completedDays: [],
});

const cycleDays = computed<SplitDay[]>(() => {
  const sourceDays = pushPullLegsSplit.days;
  return Array.from({ length: DAYS_PER_CYCLE }, (_, index) => {
    const source = sourceDays[index % sourceDays.length];
    return {
      day: index + 1,
      workout: source.workout,
    };
  });
});
const todayWorkout = computed(
  () => cycleDays.value.find((d) => d.day === state.currentDay)?.workout || [],
);
const isDoneToday = computed(() =>
  state.completedDays.includes(state.currentDay),
);
const pwa = usePWA() as unknown as {
  showInstallPrompt?: unknown;
  isInstalled?: unknown;
  isPWAInstalled?: unknown;
  needRefresh?: unknown;
  updateServiceWorker?: (reloadPage?: boolean) => Promise<unknown>;
  install?: () => Promise<unknown>;
};
const standaloneMode = ref(false);
const dismissUpdateBanner = ref(false);
const showInstallHelp = ref(false);
const isIosSafari = ref(false);
const isChromiumDesktop = ref(false);

const installHelpText = computed(() => {
  if (isIosSafari.value) {
    return "Tap Share in Safari, then choose Add to Home Screen.";
  }
  if (isChromiumDesktop.value) {
    return "Open Chrome menu (top-right) and choose Install Workout...";
  }
  return "Use your browser menu and choose Install app or Add to Home screen.";
});

const updateStandaloneMode = () => {
  if (!import.meta.client) {
    standaloneMode.value = false;
    return;
  }
  standaloneMode.value =
    window.matchMedia("(display-mode: standalone)").matches ||
    // iOS Safari standalone flag.
    Boolean(
      (window.navigator as Navigator & { standalone?: boolean }).standalone,
    );
};

const canInstall = computed(() => {
  const showInstallPrompt = Boolean(unref(pwa?.showInstallPrompt));
  const installed = isInstalled.value;
  return (
    import.meta.client &&
    showInstallPrompt &&
    typeof pwa.install === "function" &&
    !installed &&
    !standaloneMode.value
  );
});

const isInstalled = computed(
  () => Boolean(unref(pwa?.isInstalled)) || Boolean(unref(pwa?.isPWAInstalled)),
);

const canShowInstallHelp = computed(
  () =>
    import.meta.client &&
    (isIosSafari.value || isChromiumDesktop.value) &&
    !standaloneMode.value &&
    !isInstalled.value,
);

const installApp = async () => {
  if (!canInstall.value || !pwa.install) {
    return;
  }
  await pwa.install();
};

const handleInstallClick = async () => {
  if (canInstall.value) {
    await installApp();
    return;
  }
  if (canShowInstallHelp.value) {
    showInstallHelp.value = true;
  }
};

const hasPendingUpdate = computed(() => Boolean(unref(pwa?.needRefresh)));

const showUpdateBanner = computed(
  () =>
    import.meta.client && hasPendingUpdate.value && !dismissUpdateBanner.value,
);

const dismissUpdate = () => {
  dismissUpdateBanner.value = true;
};

const applyUpdate = async () => {
  if (typeof pwa.updateServiceWorker === "function") {
    await pwa.updateServiceWorker(true);
    return;
  }
  if (import.meta.client) {
    window.location.reload();
  }
};

const levelProfiles: Record<
  LevelName,
  {
    setDelta: number;
    repDelta: number;
    restDelta: number;
    roundDelta: number;
    holdDelta: number;
    effort: string;
    notes: string[];
    fallback: string;
  }
> = {
  Beginner: {
    setDelta: -1,
    repDelta: 2,
    restDelta: 15,
    roundDelta: 0,
    holdDelta: -5,
    effort: "RIR 2-3",
    notes: [
      "Prioritize technique and stable range of motion.",
      "Keep one to three reps in reserve each set.",
      "Rest fully so each set stays clean and repeatable.",
    ],
    fallback: "Use controlled tempo and stop with 2-3 reps in reserve.",
  },
  Intermediate: {
    setDelta: 0,
    repDelta: 0,
    restDelta: 0,
    roundDelta: 1,
    holdDelta: 0,
    effort: "RIR 1-2",
    notes: [
      "Progress load only when all reps are technically strong.",
      "Control eccentric phase and drive explosive concentric reps.",
      "Match effort across sets and keep execution consistent.",
    ],
    fallback: "Target 1-2 reps in reserve with strict, consistent form.",
  },
  Advanced: {
    setDelta: 1,
    repDelta: -1,
    restDelta: -10,
    roundDelta: 1,
    holdDelta: 5,
    effort: "RIR 0-1",
    notes: [
      "Push top sets close to failure while preserving mechanics.",
      "Use full intent on every rep and track performance precisely.",
      "Shorten rest only if output and technique stay high.",
    ],
    fallback: "Train close to failure with quality reps and tight execution.",
  },
};

const clamp = (value: number, min: number, max: number) =>
  Math.min(max, Math.max(min, value));

const formatWorkoutForLevel = (
  line: string,
  level: LevelName,
  index: number,
): WorkoutLine => {
  const profile = levelProfiles[level];

  const setPattern = /^(.*) - (\d+) sets x (\d+) reps(.*), rest (\d+)s$/;
  const roundPattern = /^(.*) - (\d+) rounds x (\d+) seconds, rest (\d+)s$/;
  const minutePattern = /^(.*) - (\d+) minutes \((.*)\)$/;

  const setMatch = line.match(setPattern);
  if (setMatch) {
    const [, name, sets, reps, repSuffix, rest] = setMatch;
    const nextSets = clamp(Number(sets) + profile.setDelta, 2, 6);
    const nextReps = clamp(Number(reps) + profile.repDelta, 5, 20);
    const nextRest = clamp(Number(rest) + profile.restDelta, 30, 180);

    return {
      name,
      plan: `${nextSets} sets x ${nextReps} reps${repSuffix}, rest ${nextRest}s · ${profile.effort}`,
      note: profile.notes[index % profile.notes.length],
    };
  }

  const roundMatch = line.match(roundPattern);
  if (roundMatch) {
    const [, name, rounds, seconds, rest] = roundMatch;
    const nextRounds = clamp(Number(rounds) + profile.roundDelta, 2, 6);
    const nextSeconds = clamp(Number(seconds) + profile.holdDelta, 20, 75);
    const nextRest = clamp(Number(rest) + profile.restDelta, 30, 120);

    return {
      name,
      plan: `${nextRounds} rounds x ${nextSeconds} seconds, rest ${nextRest}s · ${profile.effort}`,
      note: profile.notes[index % profile.notes.length],
    };
  }

  const minuteMatch = line.match(minutePattern);
  if (minuteMatch) {
    const [, name, minutes, detail] = minuteMatch;
    const nextMinutes = clamp(
      Number(minutes) +
        (level === "Advanced" ? 3 : level === "Beginner" ? -2 : 0),
      8,
      20,
    );

    return {
      name,
      plan: `${nextMinutes} minutes (${detail}) · ${profile.effort}`,
      note: profile.notes[index % profile.notes.length],
    };
  }

  const separator = line.indexOf(" - ");
  const name = separator > -1 ? line.slice(0, separator) : line;
  const plan = separator > -1 ? line.slice(separator + 3) : profile.fallback;

  return {
    name,
    plan: `${plan} · ${profile.effort}`,
    note: profile.notes[index % profile.notes.length],
  };
};

const detailedWorkout = computed<WorkoutLine[]>(() => {
  const level = state.level as LevelName;
  return todayWorkout.value.map((line, index) =>
    formatWorkoutForLevel(line, level, index),
  );
});

const normalizeCycleState = () => {
  const uniqueCompleted = Array.from(new Set(state.completedDays)).filter(
    (day) => Number.isInteger(day) && day > 0 && day <= DAYS_PER_CYCLE,
  );
  state.completedDays = uniqueCompleted;

  if (state.completedDays.length >= DAYS_PER_CYCLE) {
    state.currentDay = 1;
    state.completedDays = [];
    return;
  }

  if (state.completedDays.includes(state.currentDay)) {
    const nextDay = Array.from(
      { length: DAYS_PER_CYCLE },
      (_, index) => index + 1,
    ).find((day) => !state.completedDays.includes(day));
    state.currentDay = nextDay || 1;
  }
};

const completeDay = () => {
  if (isDoneToday.value) {
    return;
  }
  if (import.meta.client) {
    const ok = window.confirm("Mark today as completed and move to next day?");
    if (!ok) {
      return;
    }
  }
  if (!state.completedDays.includes(state.currentDay)) {
    state.completedDays.push(state.currentDay);
  }
  if (state.currentDay < DAYS_PER_CYCLE) {
    state.currentDay += 1;
    return;
  }
  state.currentDay = 1;
  state.completedDays = [];
};

onMounted(() => {
  updateStandaloneMode();
  window.addEventListener("appinstalled", updateStandaloneMode);
  const ua = window.navigator.userAgent;
  isIosSafari.value =
    /iPad|iPhone|iPod/.test(ua) &&
    /Safari/.test(ua) &&
    !/CriOS|FxiOS|EdgiOS/.test(ua);
  isChromiumDesktop.value =
    /Chrome|Chromium|Edg/.test(ua) &&
    !/Android|iPhone|iPad|iPod/.test(ua);

  const raw = localStorage.getItem(STORE_KEY);
  if (!raw) {
    return;
  }
  try {
    const saved = JSON.parse(raw) as Partial<WorkoutState>;
    if (saved.level && levels.includes(saved.level)) {
      state.level = saved.level;
    }
    const maxDay = DAYS_PER_CYCLE;
    if (
      saved.currentDay &&
      saved.currentDay > 0 &&
      saved.currentDay <= maxDay
    ) {
      state.currentDay = saved.currentDay;
    }
    if (Array.isArray(saved.completedDays)) {
      state.completedDays = saved.completedDays.filter(
        (d) => Number.isInteger(d) && d > 0 && d <= maxDay,
      );
    }
    normalizeCycleState();
  } catch {
    localStorage.removeItem(STORE_KEY);
  }
});

watch(
  () => ({ ...state }),
  () => {
    if (import.meta.client) {
      localStorage.setItem(STORE_KEY, JSON.stringify(state));
    }
  },
  { deep: true },
);

watch(hasPendingUpdate, (value) => {
  if (!value) {
    dismissUpdateBanner.value = false;
  }
});
</script>
