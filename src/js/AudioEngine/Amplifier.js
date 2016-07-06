import ADSR from './ADSR'
import MIDI from '../MIDI'

export default class Amplifier {
	constructor(context, state) {
		this.context = context

		/* amp adsr state */
		this.adsr = new ADSR(this.context, state.adsr)

		/* AudioNode graph routing */
		this.output = this.context.createGain()
		this.output.connect(this.context.destination)

		this._setState(state)
	}

	setMasterVolumeGain = midiValue => {
		const vol = MIDI.logScaleToMax(midiValue, 1)
		this.state.masterVolume = vol
		this.output.gain.value = vol
	}

	_setState = state => {
		this.state = {}
		this.output.gain.value = state.masterVolume
		this.state.masterVolume = state.masterVolume
	}

	setState = state => {
		this.adsr.setState(state.adsr)
		this._setState(state)
	}
}