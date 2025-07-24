package options;

class OptimizationSubState extends BaseOptionsMenu
{
    var limitCount:Option;
    var cacheCount:Option;

    public static final SORT_PATTERN:Array<String> = [
        'Never',
        'After Note Spawned',
        'After Note Processed',
        'After Note Finalized',
        'Reversed',
        'Chaotic',
        'Random',
        'Shuffle',
    ];

    public function new()
    {
        #if DISCORD_ALLOWED
        DiscordClient.changePresence("Optimizations Menu", null);
        #end

        title = 'Optimization';
        rpcTitle = 'Optimization Settings Menu';

        // Warning note
        addOption(new Option('Work in Progress',
            "Make changes at your own risk.",
            'openDoor',
            STRING,
            ['!']));

        addOption(new Option('Show Notes',
            "If unchecked, appearTime is set to 0.\nAll notes will be processed as skipped notes.\nBotplay is force-enabled.",
            'showNotes',
            BOOL));

        addOption(new Option('Show Notes again after Skip',
            "If checked, it tries preventing notes from showing only halfway through.",
            'showAfter',
            BOOL));

        addOption(new Option('Keep Notes in Screen',
            "If checked, notes will display from top to bottom, even if they are skippable.\nIf unchecked, it improves performance, especially if a lot of notes are displayed.",
            'keepNotes',
            BOOL));

        addOption(new Option('Sort Notes:',
            "If checked, the notes array is sorted every frame when notes are added.\nUnchecking improves performance.\nDefault: \"After Note Finalized\"",
            'sortNotes',
            STRING,
            SORT_PATTERN));

        addOption(new Option('Faster Sort',
            "If checked, it sorts only visible objects.",
            'fastSort',
            BOOL));

        addOption(new Option('Better Recycling',
            "Uses NoteGroup recycling to boost game performance.",
            'betterRecycle',
            BOOL));

        var option = new Option('Max Notes Shown:',
            "Limit how many notes are shown. Set to 0 for unlimited.",
            'limitNotes',
            INT);
        option.scrollSpeed = 30;
        option.minValue = 0;
        option.maxValue = 99999;
        option.changeValue = 1;
        option.decimals = 0;
        option.onChange = onChangeLimitCount;
        limitCount = option;
        addOption(option);

        option = new Option('Invisible overlapped notes:',
            "Makes overlapping notes invisible beyond a set threshold.\nNot considered cheating anymore.",
            'hideOverlapped',
            FLOAT);
        option.displayFormat = "%v pixel";
        option.scrollSpeed = 10.0;
        option.minValue = 0.0;
        option.maxValue = 10.0;
        option.changeValue = 0.1;
        option.decimals = 1;
        addOption(option);

        addOption(new Option('Process Notes before Spawning',
            "Processes notes in advance for major performance gains.\nRecommended ON.",
            'processFirst',
            BOOL));

        addOption(new Option('Skip Process for Spawned Note',
            "Enables skip logic. Helpful for big charts.",
            'skipSpawnNote',
            BOOL));

        addOption(new Option(' - Break on Time Limit Exceeded',
            "Stops processing loop if it exceeds safe time limit.",
            'breakTimeLimit',
            BOOL));

        addOption(new Option('Optimize Process for Spawned Note',
            "Evaluates notes immediately upon spawning. Useful for huge note maps.",
            'optimizeSpawnNote',
            BOOL));

        addOption(new Option('noteHitPreEvent',
            "Disables pre-hit Lua/HScript events for performance.",
            'noteHitPreEvent',
            BOOL));

        addOption(new Option('noteHitEvent',
            "Disables note hit Lua/HScript events. Not recommended to turn off.",
            'noteHitEvent',
            BOOL));

        addOption(new Option('spawnNoteEvent',
            "Disables spawn Lua/HScript events for notes.",
            'spawnNoteEvent',
            BOOL));

        addOption(new Option('noteHitEvent for stages',
            "Disables note hit events on stage logic. Only for advanced use.",
            'noteHitStage',
            BOOL));

        addOption(new Option('noteHitEvents for Skipped Notes',
            "Disables hit events for skipped notes.",
            'skipNoteEvent',
            BOOL));

        addOption(new Option('Disable Garbage Collector',
            "Skips garbage collection during gameplay. Reduces lag.",
            'disableGC',
            BOOL));

        super();
    }

    function onChangeLimitCount()
    {
        limitCount.scrollSpeed = interpolate(30, 50000, (holdTime - 0.5) / 10, 3);
    }

    function onChangeCacheCount()
    {
        cacheCount.scrollSpeed = interpolate(30, 50000, (holdTime - 0.5) / 10, 3);
    }
}
