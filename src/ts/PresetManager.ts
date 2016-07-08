export default class PresetManager<T> {

	private currentPresetIndex: number
	private presets: Array<T>

	constructor(presets: Array<T>) {
		this.presets = presets
		this.currentPresetIndex = 0
	}

	public current(): T {
		return this.presets[this.currentPresetIndex]
	}

	public next(): T {
		this.currentPresetIndex += 1
		// cycle through bank
		if (this.currentPresetIndex == this.presets.length) {
			this.currentPresetIndex = 0
		}
		return this.current()
	}

	public previous = (): T => {
		// cycle through bank
		this.currentPresetIndex -= 1

		if (this.currentPresetIndex == -1) {
			this.currentPresetIndex = this.presets.length - 1
		}
		return this.current()
	}

}
