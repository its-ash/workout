<template>
    <main class="app-shell">
        <header class="topbar glass">
            <div class="brand-left">
                <h1>Daily Split Tracker</h1>
            </div>
            <button v-if="canInstall" class="install-btn install-top-right" @click="installApp">
                Install App
            </button>
            <div class="header-actions">
                <div class="badge">{{ state.level }} · {{ activeSplit.title }}</div>
            </div>
        </header>

        <section class="workspace">
            <div class="content-stack">
                <section v-if="!state.setupDone" class="glass setup-card">
                    <p class="kicker">First Time Setup</p>
                    <h2>Pick Your Split First</h2>
                    <div class="shape-band" aria-hidden="true">
                        <span class="shape red"></span>
                        <span class="shape blue rot"></span>
                        <span class="shape yellow"></span>
                    </div>
                    <div class="selector-grid">
                        <label class="field">
                            <span>Level</span>
                            <select v-model="state.level">
                                <option v-for="level in levels" :key="level" :value="level">
                                    {{ level }}
                                </option>
                            </select>
                        </label>
                        <label class="field">
                            <span>Split Type</span>
                            <select v-model="state.splitType">
                                <option v-for="split in splitPrograms" :key="split.id" :value="split.id">
                                    {{ split.title }}
                                </option>
                            </select>
                        </label>
                    </div>
                    <div class="actions">
                        <button class="primary" @click="saveSetup">Start Workout</button>
                    </div>
                </section>

                <section v-else class="day-card">
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

        <div v-if="state.setupDone" class="actions day-actions">
            <button class="primary" :disabled="isDoneToday" @click="completeDay">
                {{ isDoneToday ? "Completed" : "Complete Day" }}
            </button>
        </div>
    </main>
</template>

<script setup lang="ts">
import { computed, onMounted, reactive, unref, watch } from "vue";

type SplitDay = { day: number; workout: string[] };
type SplitProgram = { id: string; title: string; days: SplitDay[] };
type LevelName = "Beginner" | "Intermediate" | "Advanced";
type WorkoutState = {
    level: LevelName;
    splitType: string;
    currentDay: number;
    completedDays: number[];
    setupDone: boolean;
};
type WorkoutLine = { name: string; plan: string; note: string };

const levels: LevelName[] = ["Beginner", "Intermediate", "Advanced"];
const DAYS_PER_CYCLE = 4;

const splitPrograms: SplitProgram[] = [
    {
        id: "full-body",
        title: "Full Body",
        days: [
            {
                day: 1,
                workout: [
                    "Back Squat - 4 sets x 8 reps, rest 120s",
                    "Flat Bench Press - 4 sets x 8 reps, rest 90s",
                    "Chest Supported Row - 4 sets x 10 reps, rest 75s",
                    "Walking Lunges - 3 sets x 12 reps each leg, rest 75s",
                    "Dumbbell Shoulder Press - 3 sets x 12 reps, rest 60s",
                    "Front Plank Hold - 3 rounds x 45 seconds, rest 45s",
                ],
            },
            {
                day: 2,
                workout: [
                    "Conventional Deadlift - 4 sets x 6 reps, rest 150s",
                    "Incline Dumbbell Press - 4 sets x 10 reps, rest 90s",
                    "Lat Pulldown - 4 sets x 10 reps, rest 75s",
                    "Bulgarian Split Squat - 3 sets x 10 reps each leg, rest 90s",
                    "Cable Face Pull - 3 sets x 15 reps, rest 45s",
                    "Hanging Knee Raise - 3 sets x 15 reps, rest 45s",
                ],
            },
            {
                day: 3,
                workout: [
                    "Leg Press - 4 sets x 12 reps, rest 90s",
                    "Push Ups - 4 sets x 15 reps, rest 60s",
                    "Single Arm Dumbbell Row - 4 sets x 12 reps each side, rest 60s",
                    "Romanian Deadlift - 3 sets x 10 reps, rest 90s",
                    "Lateral Raise - 3 sets x 15 reps, rest 45s",
                    "Bike Intervals - 12 minutes (40s hard / 20s easy)",
                ],
            },
        ],
    },
    {
        id: "upper-lower",
        title: "Upper / Lower",
        days: [
            {
                day: 1,
                workout: [
                    "Barbell Bench Press - 4 sets x 8 reps, rest 90s",
                    "Bent Over Barbell Row - 4 sets x 10 reps, rest 90s",
                    "Seated Dumbbell Shoulder Press - 3 sets x 10 reps, rest 75s",
                    "Wide Grip Lat Pulldown - 3 sets x 12 reps, rest 75s",
                    "EZ Bar Curl - 3 sets x 12 reps, rest 60s",
                    "Rope Triceps Pushdown - 3 sets x 12 reps, rest 60s",
                ],
            },
            {
                day: 2,
                workout: [
                    "Back Squat - 4 sets x 8 reps, rest 120s",
                    "Romanian Deadlift - 4 sets x 8 reps, rest 120s",
                    "Leg Press - 3 sets x 12 reps, rest 90s",
                    "Seated Leg Curl - 3 sets x 12 reps, rest 75s",
                    "Standing Calf Raise - 4 sets x 15 reps, rest 45s",
                    "Dead Bug - 3 sets x 12 reps each side, rest 45s",
                ],
            },
            {
                day: 3,
                workout: [
                    "Incline Barbell Press - 4 sets x 8 reps, rest 90s",
                    "Pull Up (Assisted if needed) - 4 sets x 8 reps, rest 90s",
                    "Machine Chest Press - 3 sets x 12 reps, rest 75s",
                    "Cable Seated Row - 3 sets x 12 reps, rest 75s",
                    "Dumbbell Lateral Raise - 3 sets x 15 reps, rest 45s",
                    "Overhead Rope Extension - 3 sets x 12 reps, rest 60s",
                ],
            },
            {
                day: 4,
                workout: [
                    "Front Squat - 4 sets x 6 reps, rest 120s",
                    "Barbell Hip Thrust - 4 sets x 10 reps, rest 90s",
                    "Walking Lunges - 3 sets x 12 reps each leg, rest 75s",
                    "Leg Extension - 3 sets x 15 reps, rest 60s",
                    "Seated Calf Raise - 4 sets x 15 reps, rest 45s",
                    "Core Circuit - 3 rounds (plank, reverse crunch, side plank)",
                ],
            },
        ],
    },
    {
        id: "push-pull-legs",
        title: "Push Pull Legs",
        days: [
            {
                day: 1,
                workout: [
                    "Flat Bench Press - 4 sets x 6 reps, rest 120s",
                    "Standing Overhead Press - 4 sets x 8 reps, rest 90s",
                    "Incline Dumbbell Press - 3 sets x 10 reps, rest 75s",
                    "Cable Chest Fly - 3 sets x 12 reps, rest 60s",
                    "Weighted Dips - 3 sets x 10 reps, rest 75s",
                    "Rope Triceps Pressdown - 3 sets x 12 reps, rest 60s",
                ],
            },
            {
                day: 2,
                workout: [
                    "Deadlift - 4 sets x 5 reps, rest 150s",
                    "Barbell Row - 4 sets x 8 reps, rest 90s",
                    "Pull Up - 4 sets x 8 reps, rest 90s",
                    "Single Arm Cable Row - 3 sets x 12 reps each side, rest 60s",
                    "Face Pull - 3 sets x 15 reps, rest 45s",
                    "Alternating Dumbbell Curl - 3 sets x 12 reps each arm, rest 60s",
                ],
            },
            {
                day: 3,
                workout: [
                    "Back Squat - 4 sets x 6 reps, rest 120s",
                    "Leg Press - 4 sets x 10 reps, rest 90s",
                    "Romanian Deadlift - 3 sets x 10 reps, rest 90s",
                    "Seated Leg Curl - 3 sets x 12 reps, rest 75s",
                    "Leg Extension - 3 sets x 15 reps, rest 60s",
                    "Standing Calf Raise - 4 sets x 15 reps, rest 45s",
                ],
            },
            {
                day: 4,
                workout: [
                    "Incline Bench Press - 4 sets x 8 reps, rest 90s",
                    "Arnold Press - 4 sets x 10 reps, rest 75s",
                    "Machine Chest Press - 3 sets x 12 reps, rest 75s",
                    "Cable Lateral Raise - 3 sets x 15 reps, rest 45s",
                    "Close Grip Push Up - 3 sets x 12 reps, rest 60s",
                    "Overhead Triceps Extension - 3 sets x 12 reps, rest 60s",
                ],
            },
            {
                day: 5,
                workout: [
                    "Weighted Pull Up - 4 sets x 6 reps, rest 120s",
                    "Seated Cable Row - 4 sets x 10 reps, rest 90s",
                    "Chest Supported T-Bar Row - 3 sets x 10 reps, rest 90s",
                    "Rear Delt Fly - 3 sets x 15 reps, rest 45s",
                    "Hammer Curl - 3 sets x 12 reps, rest 60s",
                    "Preacher Curl - 3 sets x 10 reps, rest 60s",
                ],
            },
            {
                day: 6,
                workout: [
                    "Front Squat - 4 sets x 8 reps, rest 120s",
                    "Romanian Deadlift - 4 sets x 8 reps, rest 120s",
                    "Walking Lunges - 3 sets x 12 reps each leg, rest 75s",
                    "Glute Bridge - 3 sets x 15 reps, rest 60s",
                    "Seated Calf Raise - 4 sets x 15 reps, rest 45s",
                    "Core Finisher - 10 minutes (mountain climber, plank, hollow hold)",
                ],
            },
        ],
    },
];

const STORE_KEY = "workout-pwa-v1";

const state = reactive<WorkoutState>({
    level: levels[0],
    splitType: splitPrograms[0].id,
    currentDay: 1,
    completedDays: [],
    setupDone: false,
});

const activeSplit = computed(
    () => splitPrograms.find((s) => s.id === state.splitType) || splitPrograms[0],
);
const cycleDays = computed<SplitDay[]>(() => {
    const sourceDays = activeSplit.value.days;
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
    install?: () => Promise<unknown>;
};

const canInstall = computed(() => {
    const showInstallPrompt = Boolean(unref(pwa?.showInstallPrompt));
    const installed =
        Boolean(unref(pwa?.isInstalled)) || Boolean(unref(pwa?.isPWAInstalled));
    return import.meta.client && showInstallPrompt && !installed;
});

const installApp = async () => {
    if (!canInstall.value || !pwa.install) {
        return;
    }
    await pwa.install();
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
        const nextDay = [1, 2, 3, 4].find(
            (day) => !state.completedDays.includes(day),
        );
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

const resetPlan = () => {
    state.currentDay = 1;
    state.completedDays = [];
};

const saveSetup = () => {
    state.currentDay = 1;
    state.completedDays = [];
    state.setupDone = true;
};

onMounted(() => {
    const raw = localStorage.getItem(STORE_KEY);
    if (!raw) {
        return;
    }
    try {
        const saved = JSON.parse(raw) as Partial<WorkoutState>;
        if (saved.level && levels.includes(saved.level)) {
            state.level = saved.level;
        }
        if (
            saved.splitType &&
            splitPrograms.some((s) => s.id === saved.splitType)
        ) {
            state.splitType = saved.splitType;
            state.setupDone = true;
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
        if (typeof saved.setupDone === "boolean") {
            state.setupDone = saved.setupDone && state.setupDone;
        }
        normalizeCycleState();
    } catch {
        localStorage.removeItem(STORE_KEY);
    }
});

watch(
    () => ({ ...state }),
    () => {
        if (import.meta.client && state.setupDone) {
            localStorage.setItem(STORE_KEY, JSON.stringify(state));
        }
    },
    { deep: true },
);
</script>
